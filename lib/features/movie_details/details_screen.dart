import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/providers/movies_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailScreen extends ConsumerWidget {
  final int movieId;
  const DetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieDetailProvider(movieId));

    return Scaffold(
      body: movieAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (movie) => CustomScrollView(
          slivers: [
            // Backdrop image hero
            SliverAppBar(
              expandedHeight: 500,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go('/'),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: movie.fullBackdropUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Movie info
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Rating & Date row
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(color: Colors.amber),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          movie.releaseDate,
                          style: const TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Overview
                    Text(
                      movie.overview,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
