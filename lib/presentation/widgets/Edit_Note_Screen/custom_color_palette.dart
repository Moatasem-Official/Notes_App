import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomColorPalette extends StatelessWidget {
  const CustomColorPalette({
    super.key,
    required this.selectedColorValue,
    required this.onTap,
  });

  final int selectedColorValue;

  final Function(int colorValue) onTap;

  static List<Color> kNoteColors = [
    Color(0xff4A4E69),
    Color(0xff9A8C98),
    Color(0xffC9ADA7),
    Color(0xffF2E9E4),
    Color(0xff22223B),
    Color(0xff4A7C59),
    Color(0xffA68A64),
    Color(0xff585123),
  ];

  @override
  Widget build(BuildContext context) {
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
                final bool isSelected = selectedColorValue == color.value;
                return GestureDetector(
                  onTap: () => onTap(color.value),
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

  bool isDarkColor(Color color) {
    return color.computeLuminance() < 0.5;
  }
}
