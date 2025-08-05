import 'package:flutter/material.dart';
import 'custom_card_container.dart';
import 'helper_functions.dart';

class CustomNoteCard extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final int color;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const CustomNoteCard({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    required this.color,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = Color(color);
    final isDark = HelperFunctions.isDarkColor(bgColor);

    final textColor = isDark ? Colors.white.withOpacity(0.95) : Colors.black87;
    final dateColor = isDark ? Colors.white.withOpacity(0.6) : Colors.black54;
    final iconColor = isDark ? Colors.red.shade200 : Colors.red.shade400;

    return CustomCardContainer(
      bgColor: bgColor,
      onTap: onTap,
      title: title,
      textColor: textColor,
      content: content,
      dateColor: dateColor,
      date: date,
      onDelete: onDelete,
      iconColor: iconColor,
    );
  }
}
