import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.titleController,
    required this.selectedColorValue,
    required this.fillColor,
  });

  final TextEditingController titleController;
  final int selectedColorValue;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      validator: (value) =>
          value?.isEmpty ?? true ? 'Title cannot be empty' : null,
      cursorColor: Color(selectedColorValue),
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
          borderSide: BorderSide(color: Color(selectedColorValue), width: 2),
        ),
      ),
    );
  }
}
