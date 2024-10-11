import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/custom_app_bar_widget.dart';
import 'package:notes_app/widgets/custom_text_form_field.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key, required this.note});
  final NoteModel note;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  void onPressedCheckIcon() {
    if (_formKey.currentState!.validate()) {
      widget.note.title = titleController.text;
      widget.note.content = contentController.text;
      widget.note.save();

      BlocProvider.of<NotesCubit>(context).getNotes();
      Navigator.pop(context);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  late String title;

  late String content;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
  }

  void titleOnSavedMethod(String? value) {
    title = value!;
  }

  void contentOnSavedMethod(String? value) {
    content = value!;
  }

  String? validatorMethod(value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomAppBarWidget(
                      appBarText: "Edit Note",
                      icon: const Icon(Icons.check_sharp),
                      onPressed: onPressedCheckIcon),
                  const SizedBox(
                    height: 250,
                  ),
                  CustomTextFormField(
                      myController: titleController,
                      validatorMethod: validatorMethod,
                      hintText: "Title",
                      onSavedMehod: titleOnSavedMethod,
                      maxLines: 1),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextFormField(
                      myController: contentController,
                      validatorMethod: validatorMethod,
                      hintText: "Content",
                      onSavedMehod: contentOnSavedMethod,
                      maxLines: 5)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
