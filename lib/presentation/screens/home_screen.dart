import 'package:flutter/material.dart';
import 'package:note_app/presentation/widgets/Home_Screen/custom_note_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
        surfaceTintColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(66, 75, 75, 75),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return CustomNoteCard(
              title: 'Hello Note',
              content: 'Hello From My Notes App Now !',
              date: DateTime.now().toString(),
              onDelete: () {},
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
