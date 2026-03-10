import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/screens/_screens.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final GoRouter router = GoRouter(
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
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
