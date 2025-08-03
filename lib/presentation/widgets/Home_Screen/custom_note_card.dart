import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  /// تحديد إذا كان اللون غامق علشان نغير لون النص والأيقونة
  bool isDarkColor(Color color) {
    // الصيغة دي بتستخدم المعادلة القياسية لحساب الإضاءة
    double brightness =
        (color.red * 299 + color.green * 587 + color.blue * 114) / 1000;
    return brightness < 128;
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Color(color);
    final isDark = isDarkColor(bgColor);
    final textColor = isDark ? Colors.white : Colors.black;
    final dateColor = isDark ? Colors.grey[300] : Colors.grey[700];
    final iconColor = isDark ? Colors.red[200] : Colors.red;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: bgColor,
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// العنوان
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 8),

              /// المحتوى المختصر
              Text(
                content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: textColor),
              ),

              const SizedBox(height: 12),

              /// الصف اللي فيه التاريخ وزرار الحذف
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getFormattedDate(DateTime.parse(date)),
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: dateColor),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: iconColor),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('EEEE, d MMMM y, HH:mm a', 'en').format(date);
  }
}
