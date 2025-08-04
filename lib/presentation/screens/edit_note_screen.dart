import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bussines_logic/cubits/cubit/notes_cubit.dart';
import 'package:note_app/data/models/note_model.dart';

// قائمة الألوان لم تتغير
const List<Color> kNoteColors = [
  Color(0xff4A4E69),
  Color(0xff9A8C98),
  Color(0xffC9ADA7),
  Color(0xffF2E9E4),
  Color(0xff22223B),
  Color(0xff4A7C59),
  Color(0xffA68A64),
  Color(0xff585123),
];

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late int _selectedColorValue;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _selectedColorValue = widget.note.color;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleUpdateNote() {
    if (_formKey.currentState!.validate()) {
      widget.note
        ..title = _titleController.text
        ..content = _contentController.text
        ..date = DateTime.now().toIso8601String()
        ..color = _selectedColorValue;

      BlocProvider.of<NotesCubit>(context).updateNote(widget.note);
    }
  }

  @override
  Widget build(BuildContext context) {
    // تحديد لون خلفية حقول النص بناءً على الوضع الفاتح/الداكن
    final textFieldFillColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withOpacity(0.05)
        : Colors.black.withOpacity(0.05);

    return BlocListener<NotesCubit, NotesCubitState>(
      listener: (context, state) {
        if (state is NotesActionSuccess) {
          BlocProvider.of<NotesCubit>(context).getNotes();
          Navigator.pop(context);
        } else if (state is NotesActionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: Scaffold(
        // === [التحسين الأول] إعادة الـ AppBar ===
        appBar: AppBar(
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
              onPressed: _handleUpdateNote,
              tooltip: 'Save Note',
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // === [التحسين الثاني] حقول نص واضحة وجميلة ===
                  _buildTitleTextField(textFieldFillColor),
                  const SizedBox(height: 24),
                  _buildColorPalette(),
                  const SizedBox(height: 24),
                  _buildContentTextField(textFieldFillColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleTextField(Color fillColor) {
    return TextFormField(
      controller: _titleController,
      validator: (value) =>
          value?.isEmpty ?? true ? 'Title cannot be empty' : null,
      cursorColor: Color(_selectedColorValue),
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: 'Title',
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, // بدون إطار في الوضع العادي
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          // إطار ملون عند التركيز على الحقل
          borderSide: BorderSide(color: Color(_selectedColorValue), width: 2),
        ),
      ),
    );
  }

  Widget _buildContentTextField(Color fillColor) {
    return TextFormField(
      controller: _contentController,
      validator: (value) =>
          value?.isEmpty ?? true ? 'Content cannot be empty' : null,
      cursorColor: Color(_selectedColorValue),
      maxLines: 15, // عدد أسطر كافٍ للملاحظات الطويلة
      minLines: 5,
      style: const TextStyle(fontSize: 16, height: 1.6),
      decoration: InputDecoration(
        hintText: 'Start typing your note here...',
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(_selectedColorValue), width: 2),
        ),
      ),
    );
  }

  Widget _buildColorPalette() {
    return SizedBox(
      height: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Color',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: kNoteColors.length,
              itemBuilder: (context, index) {
                final color = kNoteColors[index];
                final bool isSelected = _selectedColorValue == color.value;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColorValue = color.value;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.color!,
                              width: 2,
                            )
                          : Border.all(color: Colors.grey.shade400, width: 1),
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            color: isDarkColor(color)
                                ? Colors.white
                                : Colors.black,
                            size: 18,
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // دالة مساعدة لتحديد إذا كان اللون غامقًا أم فاتحًا
  bool isDarkColor(Color color) {
    return color.computeLuminance() < 0.5;
  }
}
