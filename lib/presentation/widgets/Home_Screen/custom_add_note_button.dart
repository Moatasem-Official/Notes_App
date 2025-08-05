import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bussines_logic/cubits/cubit/notes_cubit.dart';
import '../../../data/models/note_model.dart';

class CustomAddNoteButton extends StatelessWidget {
  const CustomAddNoteButton({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.contentController,
    this.isLoading = false,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: MaterialButton(
          height: 50,
          color: Colors.deepPurple,
          minWidth: double.infinity,
          onPressed: () async {
            List<int> colors = [
              0xFFEF5350, // Red
              0xFFFFA726, // Orange
              0xFFFFEE58, // Yellow
              0xFF66BB6A, // Green
              0xFF42A5F5, // Blue
              0xFFAB47BC, // Purple
              0xFF26C6DA, // Cyan
              0xFF8D6E63, // Brown
              0xFFBDBDBD, // Grey
            ];

            if (formKey.currentState!.validate()) {
              final note = NoteModel(
                title: titleController.text,
                content: contentController.text,
                date: DateTime.now().toString(),
                color: colors[Random().nextInt(colors.length)],
              );
              await context.read<NotesCubit>().addNote(note);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    'Add Note',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
