// شاشة الخدمات الحكومية
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';

class GovernmentScreen extends StatefulWidget {
  @override
  State<GovernmentScreen> createState() => _GovernmentScreenState();
}

class _GovernmentScreenState extends State<GovernmentScreen> {
  final List<Map<String, dynamic>> _services = [
    {
      'name': 'الجوازات',
      'icon': Icons.card_travel,
      'color': Colors.blue,
      'description': 'تجديد جواز السفر',
    },
    {
      'name': 'المرور',
      'icon': Icons.directions_car,
      'color': Colors.red,
      'description': 'دفع رسوم المرور',
    },
    {
      'name': 'البلدية',
      'icon': Icons.location_city,
      'color': Colors.green,
      'description': 'رسوم البلدية',
    },
    {
      'name': 'الضرائب',
      'icon': Icons.account_balance,
      'color': Colors.orange,
      'description': 'دفع الضرائب',
    },
    {
      'name': 'الجمارك',
      'icon': Icons.local_shipping,
      'color': Colors.purple,
      'description': 'رسوم جمارك',
    },
    {
      'name': 'القضاء',
      'icon': Icons.gavel,
      'color': Colors.brown,
      'description': 'دفع رسوم قضائية',
    },
    {
      'name': 'التأمينات',
      'icon': Icons.security,
      'color': Colors.teal,
      'description': 'دفع التأمينات',
    },
    {
      'name': 'التعليم',
      'icon': Icons.school,
      'color': Colors.indigo,
      'description': 'رسوم دراسية',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      appBar: CustomAppBar(
        title: 'الخدمات الحكومية',
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _services.length,
        itemBuilder: (context, index) {
          final service = _services[index];
          
          return GestureDetector(
            onTap: () => _showServiceDialog(service),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: (service['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      service['icon'] as IconData,
                      color: service['color'] as Color,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    service['name'],
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppTheme.lightText,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    service['description'],
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ).animate()
           .fadeIn(delay: (index * 100).ms)
           .scale(begin: Offset(0.9, 0.9), end: Offset(1, 1));
        },
      ),
    );
  }

  void _showServiceDialog(Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: (service['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                service['icon'] as IconData,
                color: service['color'] as Color,
                size: 28,
              ),
            ),
            SizedBox(width: 12),
            Text(
              service['name'],
              style: TextStyle(
                fontFamily: 'Changa',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service['description'],
              style: TextStyle(
                fontFamily: 'Tajawal',
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'رقم المعاملة',
                labelStyle: TextStyle(fontFamily: 'Tajawal'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'المبلغ',
                labelStyle: TextStyle(fontFamily: 'Tajawal'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyle(fontFamily: 'Tajawal'),
            ),
          ),
          GoldButton(
            text: 'دفع',
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
              'تم الدفع بنجاح!',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 22,
                fontWeight: FontWeight.bold,
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
