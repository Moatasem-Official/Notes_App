import 'package:flutter/material.dart';
import 'package:note_app/presentation/widgets/Home_Screen/Note_Card/helper_functions.dart';

class CustomCardFooter extends StatelessWidget {
  const CustomCardFooter({
    super.key,
    required this.dateColor,
    required this.date,
    required this.onDelete,
    required this.iconColor,
  });

  final Color dateColor;
  final String date;
  final VoidCallback? onDelete;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.calendar_today_outlined, size: 14, color: dateColor),
        const SizedBox(width: 8),
        Text(
          HelperFunctions.getFormattedDate(DateTime.parse(date)),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: dateColor,
            letterSpacing: 0.5,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 36,
          height: 36,
          child: InkWell(
            onTap: onDelete,
            borderRadius: BorderRadius.circular(18),
            child: Icon(Icons.delete_outline, color: iconColor, size: 20),
          ),
        ),
      ],
    );
  }
}
