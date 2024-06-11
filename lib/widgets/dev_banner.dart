import 'package:flutter/material.dart';
import 'package:vocabmate/widgets/theme.dart'; // Adjust the import according to your project structure

class DevelopmentBanner extends StatelessWidget {
  const DevelopmentBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      color: mediumViolet, // Use Vocabmate color
      child: const Text(
        '⚠️ Warning: Vocabmate is still under development and some features might not yet work.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white, // Text color
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
