import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/constants/app_constants.dart';
import 'package:note_app/presentation/widgets/Home_Screen/Bottom_Sheet/custom_add_button.dart';
import 'package:note_app/presentation/widgets/Home_Screen/Bottom_Sheet/custom_color_palette.dart';
import '../../../../bussines_logic/cubits/cubit/notes_cubit.dart';
import '../../custom_text_field.dart';

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

  int _selectedColorValue = AppConstants.kNoteColors.first.value;

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

                    CustomColorPalette(
                      selectedColorValue: _selectedColorValue,
                      onTap: (colorValue) {
                        setState(() {
                          _selectedColorValue = colorValue;
                        });
                      },
                    ),

                    const SizedBox(height: 32),

                    CustomAddButton(
                      titleController: _titleController,
                      contentController: _contentController,
                      selectedColorValue: _selectedColorValue,
                      formKey: _formKey,
                      isLoading: isLoading,
                    ),

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
}
