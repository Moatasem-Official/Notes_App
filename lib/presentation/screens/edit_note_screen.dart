import 'package:flutter/material.dart';
import 'package:note_app/presentation/widgets/custom_app_bar.dart';
import 'package:note_app/presentation/widgets/custom_text_field.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomAppBar(
          title: 'Edit Note',
          icon: Icons.check,
          onTap: () {},
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          CustomTextField(controller: titleController, labelText: 'Title'),
          const SizedBox(height: 16),
          CustomTextField(
            controller: contentController,
            labelText: 'Content',
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
