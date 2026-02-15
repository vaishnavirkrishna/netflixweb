import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/theme/app_theme.dart';
import 'package:netflix/features/home/home_screen.dart';
import 'package:netflix/features/movie_details/details_screen.dart';
import 'package:netflix/features/search/search_screen.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/movie/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return DetailScreen(movieId: id);
      },
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) {
        final query = state.uri.queryParameters['q'] ?? '';
        return SearchScreen(initialQuery: query);
      },
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Netflix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: _router,
    );
  }
}
