import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../services/supabase_service.dart';

class AuthProvider extends ChangeNotifier {
  Map<String, dynamic>? _user;
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _loadUser();
  }

  void _loadUser() {
    _user = LocalStorageService.getUser();
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await SupabaseService.signIn(email, password);
      if (response.user != null) {
        final userData = await SupabaseService.getUser(response.user!.id);
        if (userData != null) {
          _user = userData;
          await LocalStorageService.saveUser(userData);
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUp(String email, String password, Map<String, dynamic> userData) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await SupabaseService.signUp(email, password, data: userData);
      if (response.user != null) {
        await SupabaseService.createWallet(response.user!.id);
        final user = await SupabaseService.getUser(response.user!.id);
        if (user != null) {
          _user = user;
          await LocalStorageService.saveUser(user);
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await SupabaseService.signOut();
    _user = null;
    await LocalStorageService.clearUser();
    notifyListeners();
  }

  Future<void> signInAsGuest() async {
    _user = {'id': 'guest', 'email': 'guest@flexyemen.com', 'name': 'ضيف'};
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await SupabaseService.resetPassword(email);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
