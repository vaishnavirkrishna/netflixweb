import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/features/home/widgets/featured_banner.dart';
import 'package:netflix/features/home/widgets/movie_carousal.dart';
import 'package:netflix/features/home/widgets/search_bar_widget.dart';
import 'package:netflix/features/home/widgets/side_bar.dart';
import 'package:netflix/providers/movies_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.slash ||
              (event.logicalKey == LogicalKeyboardKey.keyF &&
                  HardwareKeyboard.instance.isControlPressed)) {
            context.go('/search');
          }
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            context.go('/');
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF141414),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) return const _MobileLayout();
            if (constraints.maxWidth < 1100) return const _TabletLayout();
            return const _DesktopLayout();
          },
        ),
      ),
    );
  }
}

//Shared scrollable content
class _ScrollableContent extends StatefulWidget {
  final bool showBanner;
  const _ScrollableContent({this.showBanner = false});

  @override
  State<_ScrollableContent> createState() => _ScrollableContentState();
}

class _ScrollableContentState extends State<_ScrollableContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      trackVisibility: true,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.showBanner) const FeaturedBanner(),

            MovieCarousel(
              title: 'Trending Now',
              provider: trendingMoviesProvider,
            ),
            MovieCarousel(title: 'Top Rated', provider: topRatedMoviesProvider),
            MovieCarousel(title: 'Upcoming', provider: upcomingMoviesProvider),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

//Mobile
class _MobileLayout extends ConsumerWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        SearchBarWidget(),
        Expanded(child: _ScrollableContent(showBanner: false)),
      ],
    );
  }
}

//Tablet
class _TabletLayout extends ConsumerWidget {
  const _TabletLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        SidebarWidget(),
        Expanded(
          child: Column(
            children: [
              SearchBarWidget(),
              Expanded(child: _ScrollableContent(showBanner: false)),
            ],
          ),
        ),
      ],
    );
  }
}

// Desktop
class _DesktopLayout extends ConsumerWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        SidebarWidget(),
        Expanded(
          child: Column(
            children: [
              SearchBarWidget(),
              Expanded(child: _ScrollableContent(showBanner: true)),
            ],
          ),
        ),
      ],
    );
  }
}
