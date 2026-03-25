import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/common/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      appBar: CustomAppBar(title: 'الإعدادات'),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('الوضع الداكن'),
            value: themeProvider.isDarkMode,
            onChanged: (v) => themeProvider.setDarkMode(v),
          ),
        ],
      ),
    );
  }
}
