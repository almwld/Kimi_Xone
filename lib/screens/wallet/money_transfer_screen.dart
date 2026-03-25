// شاشة تحويل الأموال
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class MoneyTransferScreen extends StatefulWidget {
  @override
  State<MoneyTransferScreen> createState() => _MoneyTransferScreenState();
}

class _MoneyTransferScreenState extends State<MoneyTransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  
  String _selectedMethod = 'wallet';
  
  final List<Map<String, dynamic>> _methods = [
    {'id': 'wallet', 'name': 'محفظة Flex', 'icon': Icons.account_balance_wallet, 'color': AppTheme.goldPrimary},
    {'id': 'bank', 'name': 'تحويل بنكي', 'icon': Icons.account_balance, 'color': Colors.blue},
    {'id': 'western', 'name': 'ويسترن يونيون', 'icon': Icons.money, 'color': Colors.orange},
    {'id': 'moneygram', 'name': 'موني جرام', 'icon': Icons.attach_money, 'color': Colors.red},
  ];

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _transfer() async {
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
              'تم التحويل بنجاح!',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'رقم العملية: #${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
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
        title: 'تحويل الأموال',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // طريقة التحويل
              Text(
                'اختر طريقة التحويل',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppTheme.lightText,
                ),
              ),
              
              SizedBox(height: 16),
              
              _buildMethodsList(),
              
              SizedBox(height: 24),
              
              // المستلم
              CustomTextField(
                label: 'رقم الهاتف أو البريد الإلكتروني',
                hint: 'أدخل بيانات المستلم',
                controller: _recipientController,
                prefixIcon: Icon(Icons.person),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 16),
              
              // المبلغ
              AmountTextField(
                label: 'المبلغ',
                controller: _amountController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 16),
              
              // ملاحظة
              CustomTextArea(
                label: 'ملاحظة (اختياري)',
                hint: 'أضف ملاحظة للتحويل',
                controller: _noteController,
                maxLines: 3,
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
                          'المبلغ',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          '${_amountController.text.isEmpty ? '0' : _amountController.text} ر.ي',
                          style: TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 18,
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
                          'رسوم التحويل',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          '0 ر.ي',
                          style: TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 16,
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
                          '${_amountController.text.isEmpty ? '0' : _amountController.text} ر.ي',
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
                text: 'تحويل',
                onPressed: _transfer,
              ),
              
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodsList() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _methods.length,
        itemBuilder: (context, index) {
          final method = _methods[index];
          final isSelected = _selectedMethod == method['id'];
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedMethod = method['id'];
              });
            },
            child: Container(
              width: 120,
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: isSelected ? AppTheme.goldGradient : null,
                color: isSelected ? null : (Theme.of(context).brightness == Brightness.dark ? AppTheme.darkSurface : Colors.white),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppTheme.goldPrimary : (Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade300),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    method['icon'] as IconData,
                    color: isSelected ? Colors.white : method['color'] as Color,
                    size: 32,
                  ),
                  SizedBox(height: 8),
                  Text(
                    method['name'],
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
}
