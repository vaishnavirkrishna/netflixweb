import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/data/models/movie.dart';
import 'package:netflix/features/home/widgets/movie_card.dart';
Widget wrapWithRouter(Widget child) {
  return MaterialApp.router(
    routerConfig: GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, __) => Scaffold(body: child)),
        GoRoute(path: '/movie/:id', builder: (_, __) => const Scaffold()),
      ],
    ),
  );
}

Movie get testMovie => Movie(
      id: 1,
      title: 'Inception',
      overview: 'A thief steals secrets through dreams.',
      releaseDate: '2010-07-16',
      voteAverage: 8.8,
      posterPath: null,
    );

void main() {
  group('MovieCard widget', () {
    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(wrapWithRouter(MovieCard(movie: testMovie)));
      await tester.pump();
      expect(find.byType(MovieCard), findsOneWidget);
    });

    testWidgets('shows error icon when poster is null', (tester) async {
      await tester.pumpWidget(wrapWithRouter(MovieCard(movie: testMovie)));
      await tester.pump(); 
      expect(find.byIcon(Icons.movie), findsOneWidget);
    });

    testWidgets('navigates to detail screen on tap', (tester) async {
      await tester.pumpWidget(wrapWithRouter(MovieCard(movie: testMovie)));
      await tester.pump();

      await tester.tap(find.byType(MovieCard));
      await tester.pumpAndSettle();
      expect(find.byType(MovieCard), findsNothing);
    });
  });
}