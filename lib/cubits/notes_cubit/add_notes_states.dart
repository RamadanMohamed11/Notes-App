abstract class AddNotesStates {}

class AddNotesInitialState extends AddNotesStates {}

class AddNotesLoadingState extends AddNotesStates {}

class AddNotesSuccessState extends AddNotesStates {}

class AddNotesErrorState extends AddNotesStates {
  final String error;
  AddNotesErrorState({required this.error});
}

// class AddNotesEmpty extends AddNotesStates {}

// class AddNotesLoaded extends AddNotesStates {}
