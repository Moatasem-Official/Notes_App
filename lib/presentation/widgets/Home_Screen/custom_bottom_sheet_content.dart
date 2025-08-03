import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: BlocConsumer<NotesCubit, NotesCubitState>(
        listener: (context, state) {
          if (state is NotesActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context); // ✅ قفل البوتوم شيت بعد النجاح
          } else if (state is NotesCubitError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
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
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final note = NoteModel(
                              title: titleController.text,
                              content: contentController.text,
                              date: DateTime.now().toString(),
                              color: Colors.deepPurple.value,
                            );
                            context.read<NotesCubit>().addNote(note);
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
          );
        },
      ),
    );
  }
}
