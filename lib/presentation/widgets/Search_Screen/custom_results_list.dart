import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../bussines_logic/cubits/cubit/notes_cubit.dart';
import '../../../data/models/note_model.dart';
import '../../screens/edit_note_screen.dart';
import '../Home_Screen/Note_Card/custom_note_card.dart';

class CustomResultsList extends StatelessWidget {
  const CustomResultsList({
    super.key,
    required this.filteredNotes,
  });

  final List<NoteModel> filteredNotes;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      key: const ValueKey('results'),
      child: ListView.builder(
        itemCount: filteredNotes.length,
        itemBuilder: (context, index) {
          final note = filteredNotes[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: CustomNoteCard(
                  title: note.title,
                  content: note.content,
                  date: note.date,
                  color: note.color,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNoteScreen(note: note),
                      ),
                    );
                  },
                  onDelete: () async {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Delete Note'),
                        content: Text(
                          'Are you sure you want to delete this note ?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await BlocProvider.of<NotesCubit>(
                                context,
                              ).deleteNote(filteredNotes[index]);
                              Navigator.pop(context);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
