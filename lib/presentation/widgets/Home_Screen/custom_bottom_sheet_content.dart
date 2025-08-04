import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bussines_logic/cubits/cubit/notes_cubit.dart';
import 'package:note_app/presentation/widgets/Home_Screen/custom_add_note_button.dart';
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
        return AbsorbPointer(
          absorbing: state is NotesCubitLoading ? true : false,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
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
                  CustomAddNoteButton(
                    formKey: formKey,
                    titleController: titleController,
                    contentController: contentController,
                    isLoading: state is NotesCubitLoading ? true : false,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
