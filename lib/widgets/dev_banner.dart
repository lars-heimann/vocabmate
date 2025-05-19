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
        '⚠️ Warning: Vocabmate is still under development and some features might not yet work.\n Due to ongoing costs in the AWS deployment of the Vocabmate backend, the service has been suspended until further notice. \n Feel free to get in touch for further information. ~Lars ',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white, // Text color
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
