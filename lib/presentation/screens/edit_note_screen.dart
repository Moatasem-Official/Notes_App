import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bussines_logic/cubits/cubit/notes_cubit.dart';
import 'package:note_app/data/models/note_model.dart';
import 'package:note_app/presentation/widgets/Edit_Note_Screen/custom_app_bar.dart';
import 'package:note_app/presentation/widgets/Edit_Note_Screen/custom_color_palette.dart';
import 'package:note_app/presentation/widgets/Edit_Note_Screen/custom_content_text_field.dart';
import 'package:note_app/presentation/widgets/Edit_Note_Screen/custom_text_field.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late int _selectedColorValue;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _selectedColorValue = widget.note.color;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleUpdateNote() {
    if (_formKey.currentState!.validate()) {
      widget.note
        ..title = _titleController.text
        ..content = _contentController.text
        ..date = DateTime.now().toIso8601String()
        ..color = _selectedColorValue;

      BlocProvider.of<NotesCubit>(context).updateNote(widget.note);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textFieldFillColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withOpacity(0.05)
        : Colors.black.withOpacity(0.05);

    return BlocListener<NotesCubit, NotesCubitState>(
      listener: (context, state) {
        if (state is NotesActionSuccess) {
          BlocProvider.of<NotesCubit>(context).getNotes();
          Navigator.pop(context);
        } else if (state is NotesActionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: CustomAppBar(handleUpdateNote: _handleUpdateNote),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  CustomTextField(
                    fillColor: textFieldFillColor,
                    selectedColorValue: _selectedColorValue,
                    titleController: _titleController,
                  ),
                  const SizedBox(height: 24),
                  CustomColorPalette(
                    selectedColorValue: _selectedColorValue,
                    onTap: (colorValue) {
                      setState(() {
                        _selectedColorValue = colorValue;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomContentTextField(
                    fillColor: textFieldFillColor,
                    selectedColorValue: _selectedColorValue,
                    contentController: _contentController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
