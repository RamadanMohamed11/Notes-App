import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubits/notes_cubit/add_notes_states.dart';
import 'package:notes_app/models/note_model.dart';

class AddNotesCubit extends Cubit<AddNotesStates> {
  AddNotesCubit() : super(AddNotesInitialState());
  addNote(NoteModel noteModel) async {
    emit(AddNotesLoadingState());
    try {
      Box<NoteModel> box = Hive.box<NoteModel>(noteBox);
      await box.add(noteModel);
      emit(AddNotesSuccessState());
    } catch (e) {
      emit(AddNotesErrorState(error: e.toString()));
    }
  }

  updateNote(NoteModel noteModel) async {
    emit(AddNotesLoadingState());

    try {
      Box<NoteModel> box = Hive.box<NoteModel>(noteBox);
      await box.putAt(noteModel.key!, noteModel);
      emit(AddNotesSuccessState());
    } catch (e) {
      emit(AddNotesErrorState(error: e.toString()));
    }
  }

  deleteNote(NoteModel noteModel) async {
    emit(AddNotesLoadingState());
    try {
      Box<NoteModel> box = Hive.box<NoteModel>(noteBox);
      await box.deleteAt(noteModel.key!);
      emit(AddNotesSuccessState());
    } catch (e) {
      emit(AddNotesErrorState(error: e.toString()));
    }
  }
}
