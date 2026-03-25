// شاشة الجامعات
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class UniversitiesScreen extends StatefulWidget {
  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentIdController = TextEditingController();
  final _amountController = TextEditingController();
  
  String _selectedUniversity = 'sanaa';
  String _selectedPaymentType = 'tuition';
  
  final List<Map<String, dynamic>> _universities = [
    {'id': 'sanaa', 'name': 'جامعة صنعاء', 'color': Colors.blue},
    {'id': 'aden', 'name': 'جامعة عدن', 'color': Colors.green},
    {'id': 'taiz', 'name': 'جامعة تعز', 'color': Colors.orange},
    {'id': 'ibb', 'name': 'جامعة إب', 'color': Colors.purple},
    {'id': 'hodeidah', 'name': 'جامعة الحديدة', 'color': Colors.teal},
    {'id': 'hadramout', 'name': 'جامعة حضرموت', 'color': Colors.red},
  ];
  
  final List<Map<String, dynamic>> _paymentTypes = [
    {'id': 'tuition', 'name': 'رسوم دراسية', 'icon': Icons.school},
    {'id': 'registration', 'name': 'رسوم تسجيل', 'icon': Icons.app_registration},
    {'id': 'exam', 'name': 'رسوم امتحانات', 'icon': Icons.quiz},
    {'id': 'certificate', 'name': 'رسوم شهادات', 'icon': Icons.card_membership},
  ];

  @override
  void dispose() {
    _studentIdController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pay() async {
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
              'تم الدفع بنجاح!',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'رقم الإيصال: #${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
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
        title: 'رسوم جامعية',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // اختيار الجامعة
              Text(
                'اختر الجامعة',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppTheme.lightText,
                ),
              ),
              
              SizedBox(height: 16),
              
              _buildUniversitiesList(),
              
              SizedBox(height: 24),
              
              // نوع الدفع
              Text(
                'نوع الدفع',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppTheme.lightText,
                ),
              ),
              
              SizedBox(height: 16),
              
              _buildPaymentTypesGrid(),
              
              SizedBox(height: 24),
              
              // رقم الطالب
              CustomTextField(
                label: 'رقم الطالب',
                hint: 'أدخل رقم الطالب الجامعي',
                controller: _studentIdController,
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
              
              SizedBox(height: 32),
              
              GoldButton(
                text: 'دفع',
                onPressed: _pay,
              ),
              
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUniversitiesList() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _universities.length,
        itemBuilder: (context, index) {
          final university = _universities[index];
          final isSelected = _selectedUniversity == university['id'];
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedUniversity = university['id'];
              });
            },
            child: Container(
              width: 120,
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: isSelected ? AppTheme.goldGradient : null,
                color: isSelected ? null : (university['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppTheme.goldPrimary : Colors.transparent,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school,
                    color: isSelected ? Colors.white : university['color'] as Color,
                    size: 32,
                  ),
                  SizedBox(height: 8),
                  Text(
                    university['name'],
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
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

  Widget _buildPaymentTypesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _paymentTypes.length,
      itemBuilder: (context, index) {
        final type = _paymentTypes[index];
        final isSelected = _selectedPaymentType == type['id'];
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedPaymentType = type['id'];
            });
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: isSelected ? AppTheme.goldGradient : null,
              color: isSelected ? null : (Theme.of(context).brightness == Brightness.dark ? AppTheme.darkSurface : Colors.white),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppTheme.goldPrimary : (Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  type['icon'] as IconData,
                  color: isSelected ? Colors.white : AppTheme.goldPrimary,
                  size: 28,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    type['name'],
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white : AppTheme.lightText),
                    ),
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
