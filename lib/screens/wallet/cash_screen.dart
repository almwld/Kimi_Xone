// شاشة السحب النقدي
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class CashScreen extends StatefulWidget {
  @override
  State<CashScreen> createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _phoneController = TextEditingController();
  
  double _selectedAmount = 5000;
  
  final List<double> _amounts = [1000, 2000, 5000, 10000, 20000, 50000];

  @override
  void dispose() {
    _amountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _requestCash() async {
    if (_formKey.currentState?.validate() ?? false) {
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
              'تم إرسال الطلب!',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'سنتواصل معك قريباً لتحديد موقع الاستلام',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.goldPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'رقم الطلب: #${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 16,
                  color: AppTheme.goldPrimary,
                ),
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
        title: 'سحب نقدي',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // معلومات
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'سيتم توصيل المبلغ المطلوب إلى موقعك خلال 24 ساعة',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 13,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
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
              
              SizedBox(height: 24),
              
              // أو مبلغ مخصص
              AmountTextField(
                label: 'أو أدخل مبلغ مخصص',
                controller: _amountController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return null; // اختياري
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 24),
              
              // رقم الهاتف
              PhoneTextField(
                label: 'رقم الهاتف للتواصل',
                controller: _phoneController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
              ),
              
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
                          'المبلغ المطلوب',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          '${_amountController.text.isNotEmpty ? _amountController.text : _selectedAmount.toStringAsFixed(0)} ر.ي',
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
                text: 'طلب سحب نقدي',
                onPressed: _requestCash,
              ),
              
              SizedBox(height: 24),
            ],
          ),
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
              _amountController.clear();
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
