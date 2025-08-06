import 'package:flutter/material.dart';
import 'package:note_app/constants/app_constants.dart';

class CustomColorPalette extends StatelessWidget {
  const CustomColorPalette({
    super.key,
    required this.selectedColorValue,
    required this.onTap,
  });

  final int selectedColorValue;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.kNoteColors.length,
        itemBuilder: (context, index) {
          final color = AppConstants.kNoteColors[index];
          final bool isSelected = selectedColorValue == color.value;
          return GestureDetector(
            onTap: () => onTap(color.value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.deepPurple : Colors.grey.shade400,
                  width: isSelected ? 2.5 : 1.5,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: isDarkColor(color) ? Colors.white : Colors.black,
                      size: 20,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  bool isDarkColor(Color color) {
    return color.computeLuminance() < 0.5;
  }
}
