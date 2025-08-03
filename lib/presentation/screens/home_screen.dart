import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:note_app/bussines_logic/cubits/cubit/notes_cubit.dart';
import 'package:note_app/data/models/note_model.dart';
import 'package:note_app/presentation/widgets/Home_Screen/custom_bottom_sheet_content.dart';
import 'package:note_app/presentation/widgets/Home_Screen/custom_list_view.dart';
import 'package:note_app/presentation/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
              return BlocListener<NotesCubit, NotesCubitState>(
                listener: (context, state) {
                  if (state is NotesCubitError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                    isLoading = false;
                  } else if (state is NotesActionSuccess) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                    isLoading = false;
                  } else if (state is NotesActionInProgress) {
                    isLoading = true;
                  }
                },
                child: ModalProgressHUD(
                  inAsyncCall: isLoading,
                  child: CustomBottomSheetContent(
                    titleController: titleController,
                    contentController: contentController,
                    onAddNote: () {
                      if (formKey.currentState!.validate()) {
                        final note = NoteModel(
                          title: titleController.text,
                          content: contentController.text,
                          date: DateTime.now().toString(),
                          color: Colors.deepPurple.value,
                        );
                        BlocProvider.of<NotesCubit>(context).addNote(note);
                        Navigator.pop(context);
                      }
                    },
                    formKey: formKey,
                    titleValidate: (p0) {
                      if (p0!.isEmpty) {
                        return 'Title Must Not Be Empty';
                      }
                      return null;
                    },
                    contentValidate: (p0) {
                      if (p0!.isEmpty) {
                        return 'Content Must Not Be Empty';
                      }
                      return null;
                    },
                  ),
                ),
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
