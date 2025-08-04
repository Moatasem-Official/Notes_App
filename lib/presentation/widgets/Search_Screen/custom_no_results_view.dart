import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNoResultsView extends StatelessWidget {
  const CustomNoResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const ValueKey('no-results'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/No data-amico.svg', height: 200),
          const SizedBox(height: 24),
          const Text(
            'Oops! Nothing Found',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "We couldn't find any notes matching your search.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
