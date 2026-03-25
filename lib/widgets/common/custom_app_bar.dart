import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;
  final int? notificationCount;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton = false,
    this.actions,
    this.onSearchTap,
    this.onNotificationTap,
    this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : const Text('FLEX YEMEN'),
      centerTitle: true,
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppTheme.darkSurface : AppTheme.lightSurface,
      leading: showBackButton ? const BackButton() : null,
      actions: actions ?? [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearchTap ?? () {},
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: onNotificationTap ?? () {},
            ),
            if (notificationCount != null && notificationCount! > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: AppTheme.goldColor,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    notificationCount.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
