import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bussines_logic/cubits/cubit/notes_cubit.dart';
import '../../data/models/note_model.dart';
import '../widgets/Home_Screen/custom_list_view.dart';
import '../widgets/Search_Screen/custom_no_results_view.dart';
import '../widgets/Search_Screen/custom_results_list.dart';
import '../widgets/Search_Screen/custom_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.allNotes});

  final List<NoteModel> allNotes;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomSearchBar(
                searchController: _searchController,
                onChanged: (query) =>
                    context.read<NotesCubit>().searchNotes(query.toLowerCase()),
              ),
              const SizedBox(height: 20),
              _buildContentBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentBody() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: BlocBuilder<NotesCubit, NotesCubitState>(
        builder: (context, state) {
          if (state is NotesCubitLoading) {
            return const CircularProgressIndicator();
          } else if (state is NotesCubitSuccess) {
            if (state.notes.isNotEmpty) {
              return CustomListView(noteItems: state.notes);
            } else {
              return const CustomNoResultsView();
            }
          } else if (state is NotesSearchActionSuccess) {
            if (state.filteredNotes.isNotEmpty) {
              return CustomResultsList(filteredNotes: state.filteredNotes);
            } else {
              return const CustomNoResultsView();
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
