// شاشة المعاملات - نسخة مصححة
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  final List<Map<String, dynamic>> _transactions = const [
    {'type': 'deposit', 'title': 'إيداع', 'amount': 50000, 'currency': 'YER', 'date': '2024-01-20', 'time': '14:30', 'status': 'completed'},
    {'type': 'withdraw', 'title': 'سحب', 'amount': 25000, 'currency': 'YER', 'date': '2024-01-19', 'time': '10:15', 'status': 'completed'},
    {'type': 'transfer', 'title': 'تحويل', 'amount': 15000, 'currency': 'YER', 'date': '2024-01-18', 'time': '16:45', 'status': 'completed'},
    {'type': 'payment', 'title': 'دفع فاتورة كهرباء', 'amount': 5000, 'currency': 'YER', 'date': '2024-01-17', 'time': '09:00', 'status': 'completed'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
        appBar: CustomAppBar(title: 'المعاملات'),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _transactions.length,
          itemBuilder: (context, index) {
            final tx = _transactions[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.arrow_downward, color: Colors.green),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tx['title'], style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
                        Text('${tx['date']} - ${tx['time']}', style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 12)),
                      ],
                    ),
                  ),
                  Text('+ ${tx['amount']} ${tx['currency']}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
