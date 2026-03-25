import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CustomAppBar({super.key, this.title, this.showBackButton = false, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : const Text('FLEX YEMEN'),
      centerTitle: true,
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppTheme.darkSurface : AppTheme.lightSurface,
      leading: showBackButton ? const BackButton() : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
