// شاشة أمازون
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';

class AmazonScreen extends StatefulWidget {
  @override
  State<AmazonScreen> createState() => _AmazonScreenState();
}

class _AmazonScreenState extends State<AmazonScreen> {
  double _selectedAmount = 25;
  final TextEditingController _emailController = TextEditingController();
  
  final List<double> _amounts = [10, 25, 50, 100, 200, 500];

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _purchase() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('الرجاء إدخال البريد الإلكتروني'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }
    
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
                  colors: [Colors.orange, Colors.orange.shade300],
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
              'بطاقة أمازون بقيمة \$${_selectedAmount.toStringAsFixed(0)}',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'تم إرسال الكود إلى:',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Text(
              _emailController.text,
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 14,
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
        title: 'Amazon Gift Card',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // شعار أمازون
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.orange.shade300],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ).animate()
             .scale(duration: 600.ms, curve: Curves.elasticOut)
             .fadeIn(),
            
            SizedBox(height: 24),
            
            // عنوان
            Center(
              child: Text(
                'Amazon Gift Card',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppTheme.lightText,
                ),
              ),
            ),
            
            SizedBox(height: 8),
            
            Center(
              child: Text(
                'اشتري بطاقة هدايا أمازون واستخدمها على موقع أمازون',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 14,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ),
            
            SizedBox(height: 32),
            
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
            
            // البريد الإلكتروني
            Text(
              'البريد الإلكتروني',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppTheme.lightText,
              ),
            ),
            
            SizedBox(height: 12),
            
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'example@email.com',
                hintStyle: TextStyle(
                  fontFamily: 'Tajawal',
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
                prefixIcon: Icon(Icons.email, color: AppTheme.goldPrimary),
                filled: true,
                fillColor: isDark ? AppTheme.darkSurface : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppTheme.goldPrimary,
                    width: 2,
                  ),
                ),
              ),
              style: TextStyle(
                fontFamily: 'Tajawal',
                color: isDark ? Colors.white : AppTheme.lightText,
              ),
            ),
            
            SizedBox(height: 32),
            
            // ملخص
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.orange.shade300],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'قيمة البطاقة',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        '\$${_selectedAmount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 18,
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
              gradient: isSelected
                  ? LinearGradient(
                      colors: [Colors.orange, Colors.orange.shade300],
                    )
                  : null,
              color: isSelected ? null : (Theme.of(context).brightness == Brightness.dark ? AppTheme.darkSurface : Colors.white),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.orange : (Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade300),
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
