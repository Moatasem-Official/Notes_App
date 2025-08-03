import 'package:flutter/material.dart';
import 'package:note_app/presentation/screens/edit_note_screen.dart';
import 'package:note_app/presentation/widgets/Home_Screen/custom_note_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
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
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Add New Note',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tilte',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Content',
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16),
                            color: Colors.deepPurple,
                            onPressed: () {},
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
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          );
        },
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
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EditNoteScreen()),
              ),
            );
          },
        ),
      ),
    );
  }
}
