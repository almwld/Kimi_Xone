// شاشة الألعاب
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';

class GamesScreen extends StatefulWidget {
  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final List<Map<String, dynamic>> _games = [
    {
      'name': 'PUBG Mobile',
      'category': 'Battle Royale',
      'image': Icons.sports_esports,
      'color': Colors.yellow.shade700,
      'packages': [
        {'name': '60 UC', 'price': 1000},
        {'name': '325 UC', 'price': 5000},
        {'name': '660 UC', 'price': 10000},
        {'name': '1800 UC', 'price': 25000},
      ],
    },
    {
      'name': 'Free Fire',
      'category': 'Battle Royale',
      'image': Icons.gamepad,
      'color': Colors.orange,
      'packages': [
        {'name': '100 Diamonds', 'price': 1000},
        {'name': '520 Diamonds', 'price': 5000},
        {'name': '1060 Diamonds', 'price': 10000},
      ],
    },
    {
      'name': 'Call of Duty',
      'category': 'FPS',
      'image': Icons.shield,
      'color': Colors.red,
      'packages': [
        {'name': '80 CP', 'price': 1000},
        {'name': '420 CP', 'price': 5000},
        {'name': '880 CP', 'price': 10000},
      ],
    },
    {
      'name': 'Mobile Legends',
      'category': 'MOBA',
      'image': Icons.flash_on,
      'color': Colors.blue,
      'packages': [
        {'name': '56 Diamonds', 'price': 1000},
        {'name': '284 Diamonds', 'price': 5000},
        {'name': '586 Diamonds', 'price': 10000},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      appBar: CustomAppBar(
        title: 'شحن الألعاب',
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _games.length,
        itemBuilder: (context, index) {
          final game = _games[index];
          
          return Container(
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkSurface : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // رأس البطاقة
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (game['color'] as Color).withOpacity(0.8),
                        game['color'] as Color,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          game['image'] as IconData,
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
                              game['name'],
                              style: TextStyle(
                                fontFamily: 'Changa',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              game['category'],
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // الباقات
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اختر الباقة',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : AppTheme.lightText,
                        ),
                      ),
                      SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: (game['packages'] as List).map((package) {
                          return GestureDetector(
                            onTap: () => _showPurchaseDialog(game['name'], package),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppTheme.goldGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    package['name'],
                                    style: TextStyle(
                                      fontFamily: 'Changa',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${package['price']} ر.ي',
                                    style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate()
           .fadeIn(delay: (index * 200).ms)
           .slideY(begin: 0.2, end: 0);
        },
      ),
    );
  }

  void _showPurchaseDialog(String gameName, Map<String, dynamic> package) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'تأكيد الشراء',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              gameName,
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              package['name'],
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 24,
                color: AppTheme.goldPrimary,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'المبلغ: ${package['price']} ر.ي',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 16,
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
              'تم الشحن بنجاح!',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'سيتم إرسال الكود إلى حسابك خلال دقائق',
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
