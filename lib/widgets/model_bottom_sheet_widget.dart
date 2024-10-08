import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notes_app/cubits/notes_cubit/add_notes_cubit.dart';
import 'package:notes_app/cubits/notes_cubit/add_notes_states.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/custom_text_form_field.dart';

class ModelBottomSheetWidget extends StatefulWidget {
  const ModelBottomSheetWidget({
    super.key,
  });

  @override
  State<ModelBottomSheetWidget> createState() => _ModelBottomSheetWidgetState();
}

class _ModelBottomSheetWidgetState extends State<ModelBottomSheetWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  late String title;

  late String content;

  void titleOnSavedMethod(String? value) {
    title = value!;
  }

  void contentOnSavedMethod(String? value) {
    content = value!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNotesCubit, AddNotesStates>(
      listener: (context, state) {
        if (state is AddNotesSuccessState) {
          Navigator.pop(context);
        }
        if (state is AddNotesErrorState) {
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
        return ModalProgressHUD(
          inAsyncCall: state is AddNotesLoadingState,
          child: SingleChildScrollView(
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
                      myController: titleController,
                      hintText: "Title",
                      validatorMethod: validatorMethod,
                      onSavedMehod: titleOnSavedMethod,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFormField(
                      maxLines: 5,
                      hintText: "Content",
                      myController: contentController,
                      validatorMethod: validatorMethod,
                      onSavedMehod: contentOnSavedMethod,
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await BlocProvider.of<AddNotesCubit>(context)
                                .addNote(NoteModel(
                                    content: contentController.text,
                                    title: titleController.text,
                                    date: DateTime.now().toString()));
                            titleController.clear();
                            contentController.clear();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Add Note",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
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
