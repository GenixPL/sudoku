import 'package:flutter/material.dart';

class SolveScreen extends StatelessWidget {
  const SolveScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('solve'),
        ],
      ),
    );
  }
}
