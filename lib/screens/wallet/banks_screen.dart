// شاشة البنوك
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class BanksScreen extends StatefulWidget {
  @override
  State<BanksScreen> createState() => _BanksScreenState();
}

class _BanksScreenState extends State<BanksScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  
  String _selectedBank = 'cby';
  String _selectedCurrency = 'YER';
  
  final List<Map<String, dynamic>> _banks = [
    {'id': 'cby', 'name': 'البنك المركزي اليمني', 'color': Colors.blue},
    {'id': 'ykb', 'name': 'بنك اليمن الدولي', 'color': Colors.green},
    {'id': 'saba', 'name': 'بنك سبأ', 'color': Colors.orange},
    {'id': 'tadhamon', 'name': 'بنك التضامن', 'color': Colors.red},
    {'id': 'ahli', 'name': 'البنك الأهلي', 'color': Colors.purple},
    {'id': 'cairo', 'name': 'بنك القاهرة', 'color': Colors.teal},
  ];

  @override
  void dispose() {
    _accountNumberController.dispose();
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
        title: 'تحويل بنكي',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // اختيار البنك
              Text(
                'اختر البنك',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppTheme.lightText,
                ),
              ),
              
              SizedBox(height: 16),
              
              _buildBanksGrid(),
              
              SizedBox(height: 24),
              
              // رقم الحساب
              CustomTextField(
                label: 'رقم الحساب',
                hint: 'أدخل رقم الحساب البنكي',
                controller: _accountNumberController,
                keyboardType: TextInputType.number,
                prefixIcon: Icon(Icons.account_balance_wallet),
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
                currency: _selectedCurrency,
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

  Widget _buildBanksGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _banks.length,
      itemBuilder: (context, index) {
        final bank = _banks[index];
        final isSelected = _selectedBank == bank['id'];
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedBank = bank['id'];
            });
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: isSelected ? AppTheme.goldGradient : null,
              color: isSelected ? null : (bank['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppTheme.goldPrimary : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : bank['color'],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      bank['name'][0],
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? bank['color'] : Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    bank['name'],
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
