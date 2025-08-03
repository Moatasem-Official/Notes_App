import 'package:flutter/material.dart';
import 'package:note_app/presentation/widgets/Home_Screen/custom_bottom_sheet_content.dart';
import 'package:note_app/presentation/widgets/Home_Screen/custom_list_view.dart';
import 'package:note_app/presentation/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomAppBar(title: 'Notes', icon: Icons.search, onTap: () {}),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CustomBottomSheetContent(
                titleController: TextEditingController(),
                contentController: TextEditingController(),
                onAddNote: () {},
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: SingleChildScrollView(child: CustomListView()),
    );
  }
}
