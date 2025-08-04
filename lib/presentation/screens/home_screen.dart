import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bussines_logic/cubits/cubit/notes_cubit.dart';
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesCubit>(context).getNotes();
  }

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
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return CustomBottomSheetContent(
                titleController: titleController,
                contentController: contentController,
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
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<NotesCubit, NotesCubitState>(
          listener: (context, state) {
            if (state is NotesActionSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is NotesCubitLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotesCubitSuccess) {
              if (state.notes.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: const Center(child: Text('Start Adding Notes Now !')),
                );
              } else {
                return CustomListView(noteItems: state.notes);
              }
            } else if (state is NotesCubitInitial) {
              return Center(child: Text('لا توجد ملاحظات بعد'));
            } else if (state is NotesCubitError) {
              return Center(child: Text('خطأ في تحميل الملاحظات'));
            } else {
              // ده عشان لو الحالة هي Action مؤقتة زي success أو error مش تعرض حاجة غلط
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
