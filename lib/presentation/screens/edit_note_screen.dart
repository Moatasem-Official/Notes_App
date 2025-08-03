import 'package:flutter/material.dart';
import 'package:note_app/presentation/widgets/custom_app_bar.dart';
import 'package:note_app/presentation/widgets/custom_text_field.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomAppBar(
          title: 'Edit Note',
          icon: Icons.check,
          onTap: () {
            if (formKey.currentState!.validate()) {}
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            CustomTextField(
              controller: titleController,
              labelText: 'Title',
              validate: (p0) {
                if (p0!.isEmpty) {
                  return 'Title Must Not Be Empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: contentController,
              labelText: 'Content',
              maxLines: 5,
              validate: (p0) {
                if (p0!.isEmpty) {
                  return 'Content Must Not Be Empty';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
