import 'package:flutter/material.dart';
import 'custom_card_footer.dart';
import 'helper_functions.dart';

class CustomCardContainer extends StatelessWidget {
  const CustomCardContainer({
    super.key,
    required this.bgColor,
    required this.onTap,
    required this.title,
    required this.textColor,
    required this.content,
    required this.dateColor,
    required this.date,
    required this.onDelete,
    required this.iconColor,
  });

  final Color bgColor;
  final VoidCallback? onTap;
  final String title;
  final Color textColor;
  final String content;
  final Color dateColor;
  final String date;
  final VoidCallback? onDelete;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [HelperFunctions.getDarkerColor(bgColor), bgColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
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
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor.withOpacity(0.85),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                Divider(color: dateColor.withOpacity(0.5)),

                const SizedBox(height: 4),

                CustomCardFooter(
                  dateColor: dateColor,
                  date: date,
                  onDelete: onDelete,
                  iconColor: iconColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
