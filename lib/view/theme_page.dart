import 'package:aventus/controller/themecontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemedContainer extends StatelessWidget {
  final Widget child;
  const ThemedContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = context
        .select((ThemeNotifier notifier) => notifier.currentTheme.cardColor);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
