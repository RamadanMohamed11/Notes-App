import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/cubits/notes_cubit/add_notes_states.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/widgets/custom_text_form_field.dart';

class ModelBottomSheetForSearchWidget extends StatefulWidget {
  const ModelBottomSheetForSearchWidget({
    super.key,
  });

  @override
  State<ModelBottomSheetForSearchWidget> createState() =>
      _ModelBottomSheetForSearchWidgetState();
}

class _ModelBottomSheetForSearchWidgetState
    extends State<ModelBottomSheetForSearchWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController searchController = TextEditingController();

  String searchText = "";

  void searchOnSavedMethod(String? value) {
    searchText = value!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {
        if (state is AddNotesSuccessState) {
          BlocProvider.of<NotesCubit>(context).getNotes();
          Navigator.pop(context);
        }
        if (state is NotesErrorState) {
          print(state.error);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Adjust for the keyboard
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),
                  CustomTextFormField(
                    maxLines: 1,
                    myController: searchController,
                    hintText: "Search",
                    validatorMethod: validatorMethod,
                    onSavedMehod: searchOnSavedMethod,
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          bool isFound = false;
                          _formKey.currentState!.save();
                          for (int i = 0;
                              i <
                                  BlocProvider.of<NotesCubit>(context)
                                      .notes
                                      .length;
                              i++) {
                            if (BlocProvider.of<NotesCubit>(context)
                                    .notes[i]
                                    .title
                                    .toLowerCase() ==
                                searchText.toLowerCase()) {
                              isFound = true;
                              break;
                            }
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                      searchText: searchText,
                                      isFound: isFound)));
                          searchController.clear();
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: state is NotesLoadingState
                                ? const CircularProgressIndicator()
                                : Text(
                                    "Search For Note",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(fontSize: 30),
                                  ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String? validatorMethod(value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }
}
