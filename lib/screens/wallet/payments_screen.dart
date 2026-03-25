// شاشة دفع الفواتير
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class PaymentsScreen extends StatefulWidget {
  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _billNumberController = TextEditingController();
  final _amountController = TextEditingController();
  
  String _selectedBillType = 'electricity';
  String _selectedCurrency = 'YER';
  
  final List<Map<String, dynamic>> _billTypes = [
    {'id': 'electricity', 'name': 'كهرباء', 'icon': Icons.electric_bolt, 'color': Colors.yellow},
    {'id': 'water', 'name': 'مياه', 'icon': Icons.water_drop, 'color': Colors.blue},
    {'id': 'internet', 'name': 'إنترنت', 'icon': Icons.wifi, 'color': Colors.green},
    {'id': 'phone', 'name': 'هاتف', 'icon': Icons.phone, 'color': Colors.purple},
    {'id': 'gas', 'name': 'غاز', 'icon': Icons.local_fire_department, 'color': Colors.orange},
    {'id': 'tv', 'name': 'تلفزيون', 'icon': Icons.tv, 'color': Colors.red},
    {'id': 'tax', 'name': 'ضرائب', 'icon': Icons.account_balance, 'color': Colors.brown},
    {'id': 'fine', 'name': 'مخالفات', 'icon': Icons.gavel, 'color': Colors.indigo},
  ];

  @override
  void dispose() {
    _billNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _payBill() async {
    if (_formKey.currentState?.validate() ?? false) {
      // محاكاة دفع الفاتورة
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
                'تم الدفع بنجاح!',
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
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      appBar: CustomAppBar(
        title: 'دفع الفواتير',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // بطاقة الرصيد
              _buildBalanceCard(),
              
              SizedBox(height: 24),
              
              // عنوان
              Text(
                'اختر نوع الفاتورة',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppTheme.lightText,
                ),
              ),
              
              SizedBox(height: 16),
              
              // أنواع الفواتير
              _buildBillTypesGrid(),
              
              SizedBox(height: 24),
              
              // تفاصيل الفاتورة
              Text(
                'تفاصيل الفاتورة',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppTheme.lightText,
                ),
              ),
              
              SizedBox(height: 16),
              
              CustomTextField(
                label: 'رقم الفاتورة',
                hint: 'أدخل رقم الفاتورة',
                controller: _billNumberController,
                prefixIcon: Icon(Icons.receipt_outlined),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 16),
              
              AmountTextField(
                label: 'المبلغ',
                controller: _amountController,
                currency: _selectedCurrency,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'هذا الحقل مطلوب';
                  }
                  if (double.tryParse(value!) == null) {
                    return 'مبلغ غير صالح';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 32),
              
              GoldButton(
                text: 'دفع الآن',
                onPressed: _payBill,
              ),
              
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppTheme.goldGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.goldShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الرصيد المتاح',
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 8),
          Text(
            '150,000 ر.ي',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ).animate()
     .fadeIn()
     .slideY(begin: -0.2, end: 0);
  }

  Widget _buildBillTypesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.85,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _billTypes.length,
      itemBuilder: (context, index) {
        final billType = _billTypes[index];
        final isSelected = _selectedBillType == billType['id'];
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedBillType = billType['id'];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: isSelected ? AppTheme.goldGradient : null,
              color: isSelected ? null : (billType['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppTheme.goldPrimary : Colors.transparent,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  billType['icon'] as IconData,
                  color: isSelected ? Colors.white : billType['color'] as Color,
                  size: 28,
                ),
                SizedBox(height: 8),
                Text(
                  billType['name'],
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ).animate()
         .fadeIn(delay: (index * 50).ms)
         .scale(begin: Offset(0.9, 0.9), end: Offset(1, 1));
      },
    );
  }
}
