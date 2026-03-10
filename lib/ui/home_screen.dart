import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandedSingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              TextButton(
                onPressed: () => context.go('/create'),
                child: Text('new'),
              ),
              TextButton(
                onPressed: () => context.go('/game-list'),
                child: Text('continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
