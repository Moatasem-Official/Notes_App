import 'package:flutter/material.dart';

class CustomContentTextField extends StatelessWidget {
  const CustomContentTextField({
    super.key,
    required this.fillColor,
    required this.selectedColorValue,
    required this.contentController,
  });

  final Color fillColor;
  final int selectedColorValue;
  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: contentController,
      validator: (value) =>
          value?.isEmpty ?? true ? 'Content cannot be empty' : null,
      cursorColor: Color(selectedColorValue),
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
          borderSide: BorderSide(color: Color(selectedColorValue), width: 2),
        ),
      ),
    );
  }
}
