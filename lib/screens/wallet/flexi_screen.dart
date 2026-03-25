// شاشة فلكسي
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';

class FlexiScreen extends StatefulWidget {
  @override
  State<FlexiScreen> createState() => _FlexiScreenState();
}

class _FlexiScreenState extends State<FlexiScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedOperator = 'sabafon';
  double _selectedAmount = 1000;
  
  final List<Map<String, dynamic>> _operators = [
    {'id': 'sabafon', 'name': 'صبافون', 'color': Colors.red},
    {'id': 'yemen_mobile', 'name': 'يمن موبايل', 'color': Colors.blue},
    {'id': 'you', 'name': 'YOU', 'color': Colors.orange},
    {'id': 'y', 'name': 'Y', 'color': Colors.purple},
  ];
  
  final List<double> _amounts = [500, 1000, 2000, 5000, 10000];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendFlexi() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('الرجاء إدخال رقم الهاتف'),
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
    
    _showSuccessDialog();
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
              'تم إرسال الفلكسي!',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${_selectedAmount.toStringAsFixed(0)} ر.ي',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 24,
                color: AppTheme.goldPrimary,
              ),
            ),
            Text(
              'إلى: ${_phoneController.text}',
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
        title: 'إرسال فلكسي',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اختيار الشركة
            Text(
              'اختر شركة الاتصالات',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppTheme.lightText,
              ),
            ),
            
            SizedBox(height: 16),
            
            _buildOperatorsList(),
            
            SizedBox(height: 24),
            
            // رقم الهاتف
            Text(
              'رقم الهاتف المستلم',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppTheme.lightText,
              ),
            ),
            
            SizedBox(height: 12),
            
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: '7XXXXXXXX',
                hintStyle: TextStyle(
                  fontFamily: 'Tajawal',
                  color: isDark ? Colors.white38 : Colors.black.withOpacity(0.38),
                ),
                prefixIcon: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: AppTheme.goldGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '+967',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
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
            
            SizedBox(height: 24),
            
            // اختيار المبلغ
            Text(
              'اختر المبلغ',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppTheme.lightText,
              ),
            ),
            
            SizedBox(height: 16),
            
            _buildAmountsGrid(),
            
            SizedBox(height: 32),
            
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
                        'المبلغ',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        '${_selectedAmount.toStringAsFixed(0)} ر.ي',
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
                        '${_selectedAmount.toStringAsFixed(0)} ر.ي',
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
              text: 'إرسال فلكسي',
              onPressed: _sendFlexi,
            ),
            
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOperatorsList() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _operators.length,
        itemBuilder: (context, index) {
          final operator = _operators[index];
          final isSelected = _selectedOperator == operator['id'];
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedOperator = operator['id'];
              });
            },
            child: Container(
              width: 100,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                gradient: isSelected ? AppTheme.goldGradient : null,
                color: isSelected ? null : (operator['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppTheme.goldPrimary : Colors.transparent,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : operator['color'],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        operator['name'][0],
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? operator['color'] : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    operator['name'],
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ).animate()
           .fadeIn(delay: (index * 100).ms)
           .slideX(begin: 0.2, end: 0);
        },
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
              gradient: isSelected ? AppTheme.goldGradient : null,
              color: isSelected ? null : (Theme.of(context).brightness == Brightness.dark ? AppTheme.darkSurface : Colors.white),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppTheme.goldPrimary : (Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade300),
              ),
            ),
            child: Center(
              child: Text(
                '${amount.toStringAsFixed(0)} ر.ي',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 14,
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
