import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class CartItem {
  final String productId;
  final String productName;
  final String? productImage;
  final double price;
  final int quantity;
  CartItem({required this.productId, required this.productName, this.productImage, required this.price, required this.quantity});
  double get total => price * quantity;
  Map<String, dynamic> toJson() => {'productId': productId, 'productName': productName, 'productImage': productImage, 'price': price, 'quantity': quantity};
  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(productId: json['productId'], productName: json['productName'], productImage: json['productImage'], price: json['price'].toDouble(), quantity: json['quantity']);
}

class OrderProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;
  int get cartItemCount => _cartItems.fold(0, (s, i) => s + i.quantity);
  double get cartTotal => _cartItems.fold(0, (s, i) => s + i.total);

  OrderProvider() { _loadCart(); }
  void _loadCart() { _cartItems = LocalStorageService.getCart().map((e) => CartItem.fromJson(e)).toList(); }
  void addToCart(CartItem item) {
    final existing = _cartItems.indexWhere((i) => i.productId == item.productId);
    if (existing >= 0) {
      _cartItems[existing] = CartItem(productId: item.productId, productName: item.productName, productImage: item.productImage, price: item.price, quantity: _cartItems[existing].quantity + item.quantity);
    } else { _cartItems.add(item); }
    LocalStorageService.addToCart(item.toJson());
    notifyListeners();
  }
  void removeFromCart(String productId) {
    _cartItems.removeWhere((i) => i.productId == productId);
    LocalStorageService.removeFromCart(productId);
    notifyListeners();
  }
  void clearCart() { _cartItems.clear(); LocalStorageService.clearCart(); notifyListeners(); }
}
