import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/bussines_logic/cubits/cubit/notes_cubit.dart';
import 'package:note_app/data/models/note_model.dart';
import 'package:note_app/presentation/screens/edit_note_screen.dart';
import 'package:note_app/presentation/widgets/Home_Screen/custom_note_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // شريط البحث بالتصميم الزجاجي
              _buildSearchBar(),
              const SizedBox(height: 20),
              // عرض المحتوى بناءً على حالة البحث
              Expanded(child: _buildContentBody()),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت شريط البحث الزجاجي
  Widget _buildSearchBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              icon: Icon(Icons.search, color: Colors.grey.shade400),
              hintText: 'Search for notes...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.shade400),
            ),
            onChanged: (query) => context.read<NotesCubit>().searchNotes(query),
          ),
        ),
      ),
    );
  }

  // ودجت المحتوى الديناميكي
  Widget _buildContentBody() {
    final query = _searchController.text;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: query.isEmpty
          ? _buildInitialView() // الحالة الأولية
          : context.read<NotesCubit>().state is NotesCubitLoading
          ? _buildNoResultsView() // حالة عدم وجود نتائج
          : _buildResultsList(), // حالة عرض النتائج
    );
  }

  // ودجت الحالة الأولية قبل البحث
  Widget _buildInitialView() {
    return Center(
      key: const ValueKey('initial'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/File searching-amico.svg',
            height: 200,
          ),
          const SizedBox(height: 24),
          const Text(
            'Discover Your Thoughts',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Find your next great idea by searching through your notes.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  // ودجت حالة عدم وجود نتائج
  Widget _buildNoResultsView() {
    return Center(
      key: const ValueKey('no-results'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/No data-amico.svg', height: 200),
          const SizedBox(height: 24),
          const Text(
            'Oops! Nothing Found',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "We couldn't find any notes matching your search.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  // ودجت عرض النتائج مع الأنيميشن
  Widget _buildResultsList() {
    return AnimationLimiter(
      key: const ValueKey('results'),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          final note = ['Note 1', 'Note 2', 'Note 3'][index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: CustomNoteCard(
                  title: note,
                  content:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  date: '20 May 2023',
                  color: 1,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNoteScreen(
                          note: NoteModel(
                            title: 'Moatasem',
                            content: 'Hello World',
                            date: DateTime.now().toIso8601String(),
                            color: 1,
                          ),
                        ),
                      ),
                    );
                  },
                  onDelete: () {
                    // يمكنك إضافة منطق الحذف هنا إذا أردت
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
