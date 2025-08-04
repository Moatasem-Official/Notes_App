import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.handleUpdateNote});

  final VoidCallback handleUpdateNote;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.transparent, // شفاف
      elevation: 0, // بدون ظل
      title: const Text(
        'Edit Note',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.check_rounded, size: 28),
          onPressed: handleUpdateNote,
          tooltip: 'Save Note',
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
