import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});
  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (i) => AnimationController(
      vsync: this, duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true, period: Duration(milliseconds: 600 + i * 150)));
    _anims = _controllers.map((c) => Tween(begin: 0.3, end: 1.0).animate(c)).toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.surfaceAlt,
            borderRadius: BorderRadius.circular(16).copyWith(bottomLeft: const Radius.circular(4)),
            border: Border.all(color: AppTheme.border, width: 0.5),
          ),
          child: Row(
            children: List.generate(3, (i) => AnimatedBuilder(
              animation: _anims[i],
              builder: (_, __) => Container(
                width: 8, height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: AppTheme.textSecondary.withOpacity(_anims[i].value),
                  shape: BoxShape.circle,
                ),
              ),
            )),
          ),
        ),
      ],
    );
  }
}
