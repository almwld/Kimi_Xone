import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../services/local_storage_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _products = [];
  List<String> _favoriteIds = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get products => _products;
  List<String> get favorites => _favoriteIds;
  bool get isLoading => _isLoading;

  ProductProvider() {
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoriteIds = LocalStorageService.getFavoriteIds();
  }

  bool isFavorite(String productId) {
    return _favoriteIds.contains(productId);
  }

  void toggleFavorite(String productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      LocalStorageService.removeFromFavorites(productId);
    } else {
      _favoriteIds.add(productId);
      LocalStorageService.addToFavorites(productId);
    }
    notifyListeners();
  }

  Future<void> getProducts({bool refresh = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      _products = await SupabaseService.getProducts();
    } catch (e) {
      print('Error loading products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
