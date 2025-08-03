import 'package:flutter/material.dart';

class CustomAddNoteButton extends StatelessWidget {
  const CustomAddNoteButton({super.key, required this.onAddNote});

  final Function() onAddNote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          color: Colors.deepPurple,
          onPressed: onAddNote,
          child: Text(
            'Add Note',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
