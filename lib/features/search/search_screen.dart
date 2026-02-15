import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/features/home/widgets/movie_card.dart';
import 'package:netflix/providers/search_provider.dart';
class SearchScreen extends ConsumerStatefulWidget {
  final String initialQuery;
  const SearchScreen({super.key, this.initialQuery = ''});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchQueryProvider.notifier).state = widget.initialQuery;
    });
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchQueryProvider.notifier).state = value;
    });
  }

  void _goBack() {
    _debounce?.cancel();
    _controller.clear();
    ref.read(searchQueryProvider.notifier).state = ''; 
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final resultsAsync = ref.watch(searchResultsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _goBack,
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Search movies...',
            hintStyle: const TextStyle(color: Colors.white38),
            border: InputBorder.none,
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.white54),
                    onPressed: () {
                      _controller.clear();
                      ref.read(searchQueryProvider.notifier).state = '';
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() {}); // ← rebuild to show/hide X button
            _onSearchChanged(value);
          },
        ),
      ),
      body: resultsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.red)),
        error: (e, _) => Center(
          child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
        ),
        data: (movies) {
          // Empty state — nothing typed yet
          if (_controller.text.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Colors.white24, size: 80),
                  SizedBox(height: 16),
                  Text(
                    'Search for a movie...',
                    style: TextStyle(color: Colors.white38, fontSize: 16),
                  ),
                ],
              ),
            );
          }
          if (movies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.movie_filter,
                    color: Colors.white24,
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No results for "${_controller.text}"',
                    style: const TextStyle(color: Colors.white38, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          // Results grid
          return LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth < 600
                  ? 2
                  : constraints.maxWidth < 1100
                  ? 4
                  : 6;
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  childAspectRatio: 0.67,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) =>
                    MovieCard(movie: movies[index]),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    Future.microtask(() {
      if (mounted) return;
      ref.read(searchQueryProvider.notifier).state = '';
    });
    super.dispose();
  }
}
