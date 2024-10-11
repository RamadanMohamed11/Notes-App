import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubits/notes_cubit/add_notes_states.dart';
import 'package:notes_app/models/note_model.dart';

class NotesCubit extends Cubit<NotesStates> {
  List<NoteModel> notes = [];
  NotesCubit() : super(NotesInitialState());
  addNote(NoteModel noteModel) async {
    emit(NotesLoadingState());
    try {
      Box<NoteModel> box = Hive.box<NoteModel>(noteBox);
      await box.add(noteModel);
      emit(AddNotesSuccessState());
    } catch (e) {
      emit(NotesErrorState(error: e.toString()));
    }
  }

  getNotes() {
    try {
      Box<NoteModel> box = Hive.box<NoteModel>(noteBox);
      notes = box.values.toList();
      emit(GetNotesSuccessState());
    } catch (e) {
      emit(NotesErrorState(error: e.toString()));
    }
  }

  updateNote(NoteModel noteModel) async {
    emit(NotesLoadingState());

    try {
      Box<NoteModel> box = Hive.box<NoteModel>(noteBox);
      await box.putAt(noteModel.key!, noteModel);
      getNotes();
      emit(GetNotesSuccessState());
    } catch (e) {
      emit(NotesErrorState(error: e.toString()));
    }
  }

  deleteNote(NoteModel noteModel) async {
    emit(NotesLoadingState());
    try {
      Box<NoteModel> box = Hive.box<NoteModel>(noteBox);
      await box.deleteAt(noteModel.key!);
      getNotes();
      emit(GetNotesSuccessState());
    } catch (e) {
      emit(NotesErrorState(error: e.toString()));
    }
  }
}
