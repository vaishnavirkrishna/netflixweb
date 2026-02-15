import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/theme/app_theme.dart';
import 'package:netflix/core/utils/responsive_util.dart';
class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.sidebarWidth(context),
      color: const Color(0xFF0D0D0D),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Netflix Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
            child: Text(
              'NETFLIX',
              style: TextStyle(
                color: AppTheme.netflixRed,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),

          // Menu Section
          _SidebarSection(
            title: 'MENU',
            items: [
              _SidebarItem(
                icon: Icons.home,
                label: 'Home',
                onTap: () => context.go('/'),
              ),
              _SidebarItem(icon: Icons.tv, label: 'TV Shows'),
              _SidebarItem(icon: Icons.movie, label: 'Movies'),
              _SidebarItem(icon: Icons.history, label: 'Recently Added'),
              _SidebarItem(icon: Icons.bookmark, label: 'My List'),
            ],
          ),

          const SizedBox(height: 24),

          // Settings Section
          _SidebarSection(
            title: 'SETTINGS',
            items: [
              _SidebarItem(icon: Icons.credit_card, label: 'Change Plan'),
              _SidebarItem(icon: Icons.help_outline, label: 'FAQ'),
              _SidebarItem(icon: Icons.support_agent, label: 'Help Center'),
              _SidebarItem(icon: Icons.description, label: 'Terms of Use'),
              _SidebarItem(icon: Icons.lock_outline, label: 'Privacy'),
            ],
          ),

          const Spacer(),

          // Version
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'NETFLIX v1.0',
              style: TextStyle(
                color: Colors.white24,
                fontSize: 11,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Section with a title label
class _SidebarSection extends StatelessWidget {
  final String title;
  final List<_SidebarItem> items;

  const _SidebarSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        ...items,
      ],
    );
  }
}

// Individual clickable sidebar item
class _SidebarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          color: _isHovered
              ? Colors.white.withValues(alpha: 0.5)
              : Colors.transparent,
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: _isHovered ? Colors.white : Colors.white54,
                size: 18,
              ),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered ? Colors.white : Colors.white54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}