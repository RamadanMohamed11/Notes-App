import 'package:flutter/material.dart';
import 'package:notes_app/widgets/custom_app_bar_widget.dart';
import 'package:notes_app/widgets/custom_text_form_field.dart';

class EditNotePage extends StatelessWidget {
  EditNotePage({super.key});
  void onPressedCheckIcon() {}
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                  myController: titleController,
                  validatorMethod: validatorMethod,
                  hintText: "Content",
                  onSavedMehod: contentOnSavedMethod,
                  maxLines: 5)
            ],
          ),
        ),
      ),
    );
  }
}
