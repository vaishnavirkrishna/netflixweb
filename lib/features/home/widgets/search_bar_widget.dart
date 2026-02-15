import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: const Color(0xFF141414),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          // Search field
          Expanded(
            child: GestureDetector(
              onTap: () => context.go('/search'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.white54, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Search...',
                      style: TextStyle(color: Colors.white38, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 20),

          // User profile
          _UserAvatar(),
        ],
      ),
    );
  }
}

class _UserAvatar extends StatefulWidget {
  @override
  State<_UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<_UserAvatar> {
  bool _isHovered = false;

  static const String _userName = 'John';

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'HI',
                style: TextStyle(color: Colors.white38, fontSize: 11),
              ),
              Text(
                _userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(width: 10),

          // Avatar circle
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
              ),
            ),
            child: Center(
              child: Text(
                _userName[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),

          const SizedBox(width: 6),

          // Dropdown arrow
          AnimatedRotation(
            turns: _isHovered ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
