abstract class NotesStates {}

class NotesInitialState extends NotesStates {}

class NotesLoadingState extends NotesStates {}

class GetNotesLoadingState extends NotesStates {}

class AddNotesSuccessState extends NotesStates {}

class GetNotesSuccessState extends NotesStates {}

class DeleteNotesSuccessState extends NotesStates {}

class NotesErrorState extends NotesStates {
  final String error;
  NotesErrorState({required this.error});
}
