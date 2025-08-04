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

  /// يحدد إذا كان اللون غامقًا لتغيير لون النص والأيقونات.
  bool isDarkColor(Color color) {
    // هذه الصيغة تستخدم المعادلة القياسية لحساب سطوع اللون.
    double brightness =
        (color.red * 299 + color.green * 587 + color.blue * 114) / 1000;
    return brightness < 128;
  }

  /// يولد لونًا أغمق قليلاً من اللون الأساسي لاستخدامه في التدرج.
  Color getDarkerColor(Color color) {
    // نقلل من الإضاءة بنسبة 20%
    final hsl = HSLColor.fromColor(color);
    final darkerHsl = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));
    return darkerHsl.toColor();
  }

  /// ينسق التاريخ بطريقة أنيقة ومختصرة.
  String getFormattedDate(DateTime date) {
    // مثال: Aug 4, 2025, 5:12 AM
    return DateFormat.yMMMd('en_US').add_jm().format(date);
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Color(color);
    final isDark = isDarkColor(bgColor);

    // تحديد ألوان النص والأيقونات بناءً على خلفية البطاقة (فاتحة أم غامقة)
    final textColor = isDark ? Colors.white.withOpacity(0.95) : Colors.black87;
    final dateColor = isDark ? Colors.white.withOpacity(0.6) : Colors.black54;
    final iconColor = isDark ? Colors.red.shade200 : Colors.red.shade400;
    final deleteBgColor = isDark
        ? Colors.white.withOpacity(0.1)
        : Colors.black.withOpacity(0.05);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        // التدرج اللوني الذي يضيف العمق
        gradient: LinearGradient(
          colors: [getDarkerColor(bgColor), bgColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        // تأثير التوهج الناعم حول البطاقة
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// العنوان - بخط أكثر جرأة ووضوحًا
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),

                /// المحتوى - مع مساحة أكبر للقراءة
                Text(
                  content,
                  maxLines: 3, // تم السماح بسطر إضافي للمحتوى
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor.withOpacity(0.85),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                /// الفاصل الجمالي
                Divider(color: dateColor.withOpacity(0.5)),

                const SizedBox(height: 4),

                /// الصف السفلي (التاريخ وزر الحذف)
                Row(
                  children: [
                    // أيقونة التاريخ لمسة جمالية
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: dateColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      getFormattedDate(DateTime.parse(date)),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: dateColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Spacer(), // يدفع زر الحذف إلى أقصى اليمين
                    // زر الحذف بتصميم محدث
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: InkWell(
                        onTap: onDelete,
                        borderRadius: BorderRadius.circular(18),
                        child: Icon(
                          Icons.delete_outline,
                          color: iconColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
