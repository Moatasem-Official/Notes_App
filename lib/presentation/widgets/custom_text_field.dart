import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.maxLines = 1,
    required this.controller,
    required this.validate,
    this.focusColor = Colors.deepPurple, // لون التركيز الافتراضي
  });

  final String labelText;
  final int maxLines;
  final TextEditingController controller;
  final String? Function(String?) validate;
  final Color focusColor;

  @override
  Widget build(BuildContext context) {
    // تحديد لون خلفية حقول النص بناءً على الوضع الفاتح/الداكن
    final textFieldFillColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withOpacity(0.05)
        : Colors.black.withOpacity(0.05);

    return TextFormField(
      validator: (value) => validate(value),
      controller: controller,
      maxLines: maxLines,
      minLines: maxLines == 1 ? null : 1,
      cursorColor: focusColor,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey.shade500),
        filled: true,
        fillColor: textFieldFillColor,
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
          borderSide: BorderSide(color: focusColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade400, width: 2),
        ),
      ),
    );
  }
}
