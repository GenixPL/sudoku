import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/ui/_ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => HomeScreen(),
            routes: [
              GoRoute(
                path: '/create',
                builder: (_, _) => CreateScreen(),
              ),
              GoRoute(
                path: '/solve/#id',
                builder: (_, state) => SolveScreen(
                  id: state.pathParameters['id']!,
                ),
              ),
              GoRoute(
                path: '/game-list',
                builder: (_, _) => GameListScreen(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
