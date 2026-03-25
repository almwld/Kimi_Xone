import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class WalletProvider extends ChangeNotifier {
  Map<String, dynamic>? _wallet;
  List<Map<String, dynamic>> _transactions = [];
  bool _isLoading = false;

  Map<String, dynamic>? get wallet => _wallet;
  List<Map<String, dynamic>> get transactions => _transactions;
  bool get isLoading => _isLoading;

  Future<void> loadWallet(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _wallet = await SupabaseService.getWallet(userId);
    } catch (e) {
      print('Error loading wallet: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
