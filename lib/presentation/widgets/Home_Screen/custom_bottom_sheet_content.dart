import 'package:flutter/material.dart';
import 'package:note_app/presentation/widgets/Home_Screen/custom_add_note_button.dart';
import 'package:note_app/presentation/widgets/custom_text_field.dart';

class CustomBottomSheetContent extends StatelessWidget {
  const CustomBottomSheetContent({
    super.key,
    required this.titleController,
    required this.contentController,
    required this.onAddNote,
    required this.formKey,
    required this.titleValidate,
    required this.contentValidate,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;
  final Function() onAddNote;
  final GlobalKey<FormState> formKey;
  final String? Function(String?) titleValidate;
  final String? Function(String?) contentValidate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                'Add New Note',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                labelText: 'Title',
                controller: titleController,
                validate: titleValidate,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Content',
                maxLines: 5,
                controller: contentController,
                validate: contentValidate,
              ),
              const SizedBox(height: 100),
              CustomAddNoteButton(onAddNote: onAddNote),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
