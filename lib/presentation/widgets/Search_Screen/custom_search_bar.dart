import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.searchController,
    required this.onChanged,
  });

  final TextEditingController searchController;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Colors.grey.shade400),
                      hintText: 'Search for notes...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                    ),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
