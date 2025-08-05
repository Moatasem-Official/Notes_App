import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bussines_logic/cubits/cubit/notes_cubit.dart';
import '../../../data/models/note_model.dart';
import '../../screens/edit_note_screen.dart';
import 'Note_Card/custom_note_card.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.noteItems});

  final List<NoteModel> noteItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: noteItems.length,
      itemBuilder: (context, index) {
        return CustomNoteCard(
          title: noteItems[index].title,
          content: noteItems[index].content,
          date: noteItems[index].date,
          color: noteItems[index].color,
          onDelete: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Delete Note'),
                content: Text('Are you sure you want to delete this note ?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await BlocProvider.of<NotesCubit>(
                        context,
                      ).deleteNote(noteItems[index]);
                      Navigator.pop(context);
                    },
                    child: Text('Delete'),
                  ),
                ],
              ),
            );
          },
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditNoteScreen(note: noteItems[index]),
            ),
          ),
        );
      },
    );
  }
}
