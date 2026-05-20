import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickActionFAB extends StatefulWidget {
  const QuickActionFAB({super.key});

  @override
  State<QuickActionFAB> createState() => _QuickActionFABState();
}

class _QuickActionFABState extends State<QuickActionFAB> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isOpen) ...[
          _buildActionButton(
            context,
            label: 'New DCR Entry',
            icon: Icons.edit_note,
            onPressed: () {
              _toggle();
              context.push('/dcr-daily');
            },
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            context,
            label: 'Register Doctor',
            icon: Icons.person_add,
            onPressed: () {
              _toggle();
              context.push('/doctors');
            },
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            context,
            label: 'Register Chemist',
            icon: Icons.store_mall_directory_outlined,
            onPressed: () {
              _toggle();
              context.push('/chemists');
            },
          ),
          const SizedBox(height: 12),
        ],
        FloatingActionButton.extended(
          onPressed: _toggle,
          icon: AnimatedRotation(
            turns: _isOpen ? 0.125 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.add),
          ),
          label: Text(_isOpen ? 'Close' : 'Quick Action'),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);

    return ScaleTransition(
      scale: _expandAnimation,
      child: FadeTransition(
        opacity: _expandAnimation,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 2,
              color: theme.colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            FloatingActionButton.small(
              heroTag: label,
              onPressed: onPressed,
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: theme.colorScheme.onSecondary,
              child: Icon(icon),
            ),
          ],
        ),
      ),
    );
  }
}
