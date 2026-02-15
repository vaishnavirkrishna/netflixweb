import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/utils/responsive_util.dart';
import 'package:netflix/data/models/movie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
class MovieCard extends StatefulWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go('/movie/${widget.movie.id}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: Responsive.cardWidth(context),
          margin: const EdgeInsets.only(right: 12),
        transform: _isHovered
    ? Matrix4.diagonal3Values(1.05, 1.05, 1.0)
    : Matrix4.identity(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: widget.movie.fullPosterUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[600]!,
                child: Container(color: Colors.grey[800]),
              ),
              errorWidget: (context, url, error) => Container(
                color: const Color(0xFF1F1F1F),
                child: const Icon(Icons.movie, color: Colors.white30, size: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }
}