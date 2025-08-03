import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:note_app/bussines_logic/cubits/cubit/notes_cubit.dart';
import 'package:note_app/data/models/note_model.dart';
import 'package:note_app/presentation/widgets/custom_text_field.dart';

class CustomBottomSheetContent extends StatelessWidget {
  const CustomBottomSheetContent({
    super.key,
    required this.titleController,
    required this.contentController,
    required this.formKey,
    required this.titleValidate,
    required this.contentValidate,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;
  final GlobalKey<FormState> formKey;
  final String? Function(String?) titleValidate;
  final String? Function(String?) contentValidate;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesCubitState>(
      listener: (context, state) {
        if (state is NotesActionSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pop(context);
        } else if (state is NotesCubitError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is NotesCubitLoading ? true : false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: MaterialButton(
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
                          child: Text('Add Note'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
