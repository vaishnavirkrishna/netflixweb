
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/providers/movies_provider.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedBanner extends ConsumerWidget {
  const FeaturedBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(trendingMoviesProvider) ;

    return moviesAsync.when(
      loading: () => _buildShimmer(),
      error: (e, _) => const SizedBox.shrink(),
      data: (movies) {
        if (movies.isEmpty) return const SizedBox.shrink();
        final featured = movies.first; 

        return GestureDetector(
          onTap: () => context.go('/movie/${featured.id}'),
          child: Stack(
            children: [
              SizedBox(
                height: 480,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: featured.fullBackdropUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => _buildShimmer(),
                  errorWidget: (_, _, _) => Container(
                    color: const Color(0xFF1F1F1F),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.8)
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        const Color(0xFF141414),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 60,
                left: 48,
                child: SizedBox(
                  width: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        featured.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Rating + date
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            featured.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                                color: Colors.amber, fontSize: 14),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            featured.releaseDate.length >= 4
                                ? featured.releaseDate.substring(0, 4)
                                : featured.releaseDate,
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        featured.overview,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Buttons
                      Row(
                        children: [
                          // Play button
                          ElevatedButton.icon(
                            onPressed: () =>
                                context.go('/movie/${featured.id}'),
                            icon: const Icon(Icons.play_arrow,
                                color: Colors.black),
                            label: const Text(
                              'Play',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: () =>
                                context.go('/movie/${featured.id}'),
                            icon: const Icon(Icons.info_outline,
                                color: Colors.white),
                            label: const Text(
                              'More Info',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        height: 480,
        width: double.infinity,
        color: Colors.grey[800],
      ),
    );
  }
}