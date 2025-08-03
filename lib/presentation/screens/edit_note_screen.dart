import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bussines_logic/cubits/cubit/notes_cubit.dart';
import 'package:note_app/data/models/note_model.dart';
import 'package:note_app/presentation/widgets/custom_app_bar.dart';
import 'package:note_app/presentation/widgets/custom_text_field.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.note.title);
    final contentController = TextEditingController(text: widget.note.content);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomAppBar(
          title: 'Edit Note',
          icon: Icons.check,
          onTap: () {
            if (formKey.currentState!.validate()) {
              widget.note
                ..title = titleController.text
                ..content = contentController.text
                ..date = DateTime.now().toString();

              BlocProvider.of<NotesCubit>(context).updateNote(widget.note);
            }
          },
        ),
      ),
      body: BlocConsumer<NotesCubit, NotesCubitState>(
        listener: (context, state) {
          if (state is NotesActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context);
          } else if (state is NotesActionError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Form(
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
          );
        },
      ),
    );
  }
}
