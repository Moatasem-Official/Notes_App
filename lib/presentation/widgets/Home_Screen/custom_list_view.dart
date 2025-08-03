import 'package:flutter/material.dart';
import 'package:note_app/presentation/screens/edit_note_screen.dart';
import 'package:note_app/presentation/widgets/Home_Screen/custom_note_card.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return CustomNoteCard(
          title: 'Hello Note',
          content: 'Hello From My Notes App Now !',
          date: DateTime.now().toString(),
          onDelete: () {},
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditNoteScreen()),
          ),
        );
      },
    );
  }
}
