import 'package:flutter/material.dart';

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool includeBottomBorder;
  final List<Widget> actions;

  const ProductAppBar({required this.title, this.backgroundColor, this.foregroundColor, this.includeBottomBorder = true, this.actions = const [], super.key});

  @override
  Widget build(BuildContext context) {
    final lBackgroundColor = backgroundColor ?? Theme.of(context).colorScheme.background;
    final lForegroundColor = foregroundColor ?? Theme.of(context).colorScheme.onBackground;

    return AppBar(
        title: Text(title),
        backgroundColor: lBackgroundColor,
        foregroundColor: lForegroundColor,
        bottom: includeBottomBorder ? PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
            height: 1,
          ),
        ) : null,
        actions: actions
      );
  }
  
  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}