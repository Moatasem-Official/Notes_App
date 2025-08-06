import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:note_app/data/helpers/helper_functions.dart';
import '../../bussines_logic/cubits/cubit/notes_cubit.dart';
import 'search_notes_screen.dart';
import '../widgets/Home_Screen/Bottom_Sheet/custom_bottom_sheet_content.dart';
import '../widgets/Home_Screen/custom_list_view.dart';
import '../widgets/custom_app_bar.dart';

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
        child: CustomAppBar(
          title: 'Nota',
          icon: Icons.search,
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(
                  allNotes: BlocProvider.of<NotesCubit>(context).allNotes,
                ),
              ),
            );

            BlocProvider.of<NotesCubit>(context).getNotes();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return CustomBottomSheetContent();
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<NotesCubit, NotesCubitState>(
          listener: (context, state) {
            if (state is NotesActionSuccess) {
              Get.showSnackbar(
                HelperFunctions.customAppSnackBar(
                  message: state.message,
                  color: Colors.green,
                  icon: Icons.check,
                ),
              );
            } else if (state is NotesActionError) {
              Get.showSnackbar(
                HelperFunctions.customAppSnackBar(
                  message: state.message,
                  color: Colors.red,
                  icon: Icons.error,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is NotesCubitLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotesCubitSuccess) {
              if (state.notes.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Notes-amico.svg',
                        height: 300,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Start Adding Notes Now',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return CustomListView(noteItems: state.notes);
              }
            } else if (state is NotesCubitError) {
              return Center(child: Text('خطأ في تحميل الملاحظات'));
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
