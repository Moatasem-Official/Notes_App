import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomInitialView extends StatelessWidget {
  const CustomInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const ValueKey('initial'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/File searching-amico.svg',
            height: 200,
          ),
          const SizedBox(height: 24),
          const Text(
            'Discover Your Thoughts',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Find your next great idea by searching through your notes.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
