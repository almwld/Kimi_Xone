// شاشة التطبيقات
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';

class AppsScreen extends StatefulWidget {
  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  final List<Map<String, dynamic>> _apps = [
    {
      'name': 'Spotify Premium',
      'category': 'موسيقى',
      'icon': Icons.music_note,
      'color': Colors.green,
      'description': 'اشتراك شهر واحد',
      'price': 5000,
    },
    {
      'name': 'YouTube Premium',
      'category': 'فيديو',
      'icon': Icons.play_circle_fill,
      'color': Colors.red,
      'description': 'اشتراك شهر واحد',
      'price': 8000,
    },
    {
      'name': 'Netflix',
      'category': 'أفلام',
      'icon': Icons.movie,
      'color': Colors.red.shade900,
      'description': 'اشتراك شهر واحد',
      'price': 12000,
    },
    {
      'name': 'ChatGPT Plus',
      'category': 'ذكاء اصطناعي',
      'icon': Icons.chat,
      'color': Colors.green.shade700,
      'description': 'اشتراك شهر واحد',
      'price': 20000,
    },
    {
      'name': 'Canva Pro',
      'category': 'تصميم',
      'icon': Icons.palette,
      'color': Colors.blue.shade700,
      'description': 'اشتراك شهر واحد',
      'price': 6000,
    },
    {
      'name': 'Adobe Creative',
      'category': 'تصميم',
      'icon': Icons.brush,
      'color': Colors.red.shade700,
      'description': 'اشتراك شهر واحد',
      'price': 25000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      appBar: CustomAppBar(
        title: 'اشتراكات التطبيقات',
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _apps.length,
        itemBuilder: (context, index) {
          final app = _apps[index];
          
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkSurface : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (app['color'] as Color).withOpacity(0.8),
                        app['color'] as Color,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    app['icon'] as IconData,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app['name'],
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : AppTheme.lightText,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: (app['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          app['category'],
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 12,
                            color: app['color'] as Color,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        app['description'],
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${app['price']} ر.ي',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.goldPrimary,
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: 90,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => _subscribe(app),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.goldPrimary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'اشتراك',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).animate()
           .fadeIn(delay: (index * 100).ms)
           .slideX(begin: 0.2, end: 0);
        },
      ),
    );
  }

  void _subscribe(Map<String, dynamic> app) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'تأكيد الاشتراك',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (app['color'] as Color).withOpacity(0.8),
                    app['color'] as Color,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                app['icon'] as IconData,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(height: 16),
            Text(
              app['name'],
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              app['description'],
              style: TextStyle(
                fontFamily: 'Tajawal',
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'المبلغ: ${app['price']} ر.ي',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 20,
                color: AppTheme.goldPrimary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyle(
                fontFamily: 'Tajawal',
                color: Colors.grey,
              ),
            ),
          ),
          GoldButton(
            text: 'تأكيد',
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog();
            },
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.green.shade300],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 50,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'تم الاشتراك بنجاح!',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'سيتم إرسال تفاصيل الاشتراك إلى بريدك الإلكتروني',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          GoldButton(
            text: 'حسناً',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
