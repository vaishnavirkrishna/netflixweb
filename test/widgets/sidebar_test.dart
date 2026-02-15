import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/features/home/widgets/side_bar.dart';


Widget wrapWithRouter(Widget child) {
  return MaterialApp.router(
    routerConfig: GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, __) => Scaffold(body: child)),
        GoRoute(path: '/search', builder: (_, __) => const Scaffold()),
      ],
    ),
  );
}

void main() {
  group('SidebarWidget', () {
    testWidgets('shows NETFLIX logo', (tester) async {
      await tester.pumpWidget(wrapWithRouter(const SidebarWidget()));
      expect(find.text('NETFLIX'), findsOneWidget);
    });

    testWidgets('shows all menu items', (tester) async {
      await tester.pumpWidget(wrapWithRouter(const SidebarWidget()));

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('TV Shows'), findsOneWidget);
      expect(find.text('Movies'), findsOneWidget);
      expect(find.text('My List'), findsOneWidget);
    });

    testWidgets('shows MENU and SETTINGS section labels', (tester) async {
      await tester.pumpWidget(wrapWithRouter(const SidebarWidget()));

      expect(find.text('MENU'), findsOneWidget);
      expect(find.text('SETTINGS'), findsOneWidget);
    });

    testWidgets('shows version text at bottom', (tester) async {
      await tester.pumpWidget(wrapWithRouter(const SidebarWidget()));
      expect(find.text('NETFLIX v1.0'), findsOneWidget);
    });
  });
}