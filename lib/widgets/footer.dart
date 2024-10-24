import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Footer Content Here',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Additional footer information can go here.',
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
