// شاشة بطاقات الهدايا
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';

class GiftCardsScreen extends StatefulWidget {
  @override
  State<GiftCardsScreen> createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen> {
  String _selectedCard = 'amazon';
  double _selectedAmount = 50;
  
  final List<Map<String, dynamic>> _cards = [
    {
      'id': 'amazon',
      'name': 'Amazon',
      'color': Colors.orange,
      'icon': Icons.shopping_cart,
      'description': 'بطاقة هدايا أمازون',
    },
    {
      'id': 'google',
      'name': 'Google Play',
      'color': Colors.green,
      'icon': Icons.play_arrow,
      'description': 'بطاقة جوجل بلاي',
    },
    {
      'id': 'apple',
      'name': 'App Store',
      'color': Colors.blue,
      'icon': Icons.apple,
      'description': 'بطاقة آب ستور',
    },
    {
      'id': 'steam',
      'name': 'Steam',
      'color': Colors.indigo,
      'icon': Icons.games,
      'description': 'بطاقة ستيم',
    },
    {
      'id': 'netflix',
      'name': 'Netflix',
      'color': Colors.red,
      'icon': Icons.movie,
      'description': 'بطاقة نتفليكس',
    },
    {
      'id': 'spotify',
      'name': 'Spotify',
      'color': Colors.green.shade700,
      'icon': Icons.music_note,
      'description': 'بطاقة سبوتيفاي',
    },
  ];
  
  final List<double> _amounts = [10, 25, 50, 100, 200, 500];

  Future<void> _purchase() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.goldPrimary),
        ),
      ),
    );
    
    await Future.delayed(Duration(seconds: 2));
    
    Navigator.pop(context);
    
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
              'تم الشراء بنجاح!',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'تم إرسال كود البطاقة إلى بريدك الإلكتروني',
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      appBar: CustomAppBar(
        title: 'بطاقات الهدايا',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقات الهدايا المتاحة
            Text(
              'اختر البطاقة',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppTheme.lightText,
              ),
            ),
            
            SizedBox(height: 16),
            
            _buildCardsGrid(),
            
            SizedBox(height: 24),
            
            // اختيار المبلغ
            Text(
              'اختر المبلغ (دولار)',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppTheme.lightText,
              ),
            ),
            
            SizedBox(height: 16),
            
            _buildAmountsGrid(),
            
            SizedBox(height: 24),
            
            // ملخص
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'البطاقة',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        _cards.firstWhere((c) => c['id'] == _selectedCard)['name'],
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'المبلغ',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        '\$${_selectedAmount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.white.withOpacity(0.3), height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الإجمالي',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '\$${_selectedAmount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32),
            
            GoldButton(
              text: 'شراء الآن',
              onPressed: _purchase,
            ),
            
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCardsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _cards.length,
      itemBuilder: (context, index) {
        final card = _cards[index];
        final isSelected = _selectedCard == card['id'];
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedCard = card['id'];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: isSelected ? AppTheme.goldGradient : null,
              color: isSelected ? null : (card['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppTheme.goldPrimary : Colors.transparent,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  card['icon'] as IconData,
                  color: isSelected ? Colors.white : card['color'] as Color,
                  size: 40,
                ),
                SizedBox(height: 12),
                Text(
                  card['name'],
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white : AppTheme.lightText),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  card['description'],
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 11,
                    color: isSelected ? Colors.white.withOpacity(0.8) : (Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ).animate()
         .fadeIn(delay: (index * 100).ms)
         .scale(begin: Offset(0.9, 0.9), end: Offset(1, 1));
      },
    );
  }

  Widget _buildAmountsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _amounts.length,
      itemBuilder: (context, index) {
        final amount = _amounts[index];
        final isSelected = _selectedAmount == amount;
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedAmount = amount;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: isSelected ? AppTheme.goldGradient : null,
              color: isSelected ? null : (Theme.of(context).brightness == Brightness.dark ? AppTheme.darkSurface : Colors.white),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppTheme.goldPrimary : (Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade300),
              ),
            ),
            child: Center(
              child: Text(
                '\$${amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white : AppTheme.lightText),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
