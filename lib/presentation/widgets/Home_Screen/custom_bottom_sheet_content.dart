import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bussines_logic/cubits/cubit/notes_cubit.dart';
import '../../../data/models/note_model.dart';
import '../custom_text_field.dart';

const List<Color> kNoteColors = [
  Color(0xff4A4E69),
  Color(0xff9A8C98),
  Color(0xffC9ADA7),
  Color(0xffF2E9E4),
  Color(0xff22223B),
  Color(0xff4A7C59),
  Color(0xffA68A64),
  Color(0xff585123),
];

class CustomBottomSheetContent extends StatefulWidget {
  const CustomBottomSheetContent({super.key});

  @override
  State<CustomBottomSheetContent> createState() =>
      _CustomBottomSheetContentState();
}

class _CustomBottomSheetContentState extends State<CustomBottomSheetContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  int _selectedColorValue = kNoteColors.first.value;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesCubitState>(
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
      builder: (context, state) {
        final isLoading = state is NotesCubitLoading;
        return AbsorbPointer(
          absorbing: isLoading,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(height: 24),

                    CustomTextField(
                      labelText: 'Title',
                      controller: _titleController,
                      validate: (value) => value?.isEmpty ?? true
                          ? 'Title cannot be empty'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Content',
                      maxLines: 5,
                      controller: _contentController,
                      validate: (value) => value?.isEmpty ?? true
                          ? 'Content cannot be empty'
                          : null,
                    ),
                    const SizedBox(height: 24),

                    _buildColorPalette(),

                    const SizedBox(height: 32),

                    _buildAddButton(isLoading),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorPalette() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kNoteColors.length,
        itemBuilder: (context, index) {
          final color = kNoteColors[index];
          final bool isSelected = _selectedColorValue == color.value;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColorValue = color.value;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.deepPurple : Colors.grey.shade400,
                  width: isSelected ? 2.5 : 1.5,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: isDarkColor(color) ? Colors.white : Colors.black,
                      size: 20,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final newNote = NoteModel(
              title: _titleController.text,
              content: _contentController.text,
              date: DateTime.now().toIso8601String(),
              color: _selectedColorValue,
            );
            BlocProvider.of<NotesCubit>(context).addNote(newNote);
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Colors.deepPurple, Color(0xFF8168DD)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : const Text(
                    'Add Note',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  bool isDarkColor(Color color) {
    return color.computeLuminance() < 0.5;
  }
}
