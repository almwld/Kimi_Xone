import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final client = Supabase.instance.client;

  static User? get currentUser => client.auth.currentUser;
  static bool get isAuthenticated => currentUser != null;

  // ========== المصادقة ==========
  static Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(email: email, password: password);
  }

  static Future<AuthResponse> signUp(String email, String password, {Map<String, dynamic>? data}) async {
    return await client.auth.signUp(email: email, password: password, data: data);
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }

  static Future<void> updatePassword(String newPassword) async {
    await client.auth.updateUser(UserAttributes(password: newPassword));
  }

  static Future<void> signInWithPhone({required String phone}) async {
    await client.auth.signInWithOtp(phone: phone);
  }

  static Future<AuthResponse> verifyOTP({required String phone, required String token}) async {
    return await client.auth.verifyOTP(phone: phone, token: token, type: OtpType.sms);
  }

  // ========== المستخدم ==========
  static Future<Map<String, dynamic>?> getUser(String userId) async {
    return await client.from('profiles').select().eq('id', userId).maybeSingle();
  }

  static Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await client.from('profiles').update(data).eq('id', userId);
  }

  static Future<String> uploadAvatar(String userId, String path) async {
    // مؤقتاً - سيتم تنفيذ رفع الصورة لاحقاً
    return 'https://via.placeholder.com/150';
  }

  // ========== المنتجات ==========
  static Future<List<Map<String, dynamic>>> getProducts({
    String? category,
    int limit = 20,
    int offset = 0,
  }) async {
    var query = client.from('products').select();
    if (category != null && category.isNotEmpty) {
      query = query.filter('category', 'eq', category);
    }
    final response = await query.order('created_at', ascending: false).range(offset, offset + limit - 1);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>?> getProduct(String id) async {
    return await client.from('products').select().eq('id', id).maybeSingle();
  }

  static Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    return await client.from('products').insert(data).select().single();
  }

  static Future<void> updateProduct(String id, Map<String, dynamic> data) async {
    await client.from('products').update(data).eq('id', id);
  }

  static Future<void> deleteProduct(String id) async {
    await client.from('products').delete().eq('id', id);
  }

  // ========== المفضلة ==========
  static Future<void> addToFavorites(String userId, String productId) async {
    await client.from('favorites').insert({'user_id': userId, 'product_id': productId});
  }

  static Future<void> removeFromFavorites(String userId, String productId) async {
    await client.from('favorites').delete().eq('user_id', userId).eq('product_id', productId);
  }

  static Future<List<String>> getFavorites(String userId) async {
    final response = await client.from('favorites').select('product_id').eq('user_id', userId);
    return List<String>.from(response.map((e) => e['product_id']));
  }

  // ========== المحفظة ==========
  static Future<Map<String, dynamic>?> getWallet(String userId) async {
    return await client.from('wallets').select().eq('user_id', userId).maybeSingle();
  }

  static Future<void> createWallet(String userId) async {
    await client.from('wallets').insert({'user_id': userId, 'yer_balance': 0, 'sar_balance': 0, 'usd_balance': 0});
  }

  static Future<void> updateBalance(String walletId, String currency, double amount) async {
    await client.from('wallets').update({'${currency.toLowerCase()}_balance': amount}).eq('id', walletId);
  }

  static Future<void> createTransaction(Map<String, dynamic> data) async {
    await client.from('transactions').insert(data);
  }

  static Future<List<Map<String, dynamic>>> getTransactions(String userId, {int limit = 20}) async {
    final response = await client
        .from('transactions')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .limit(limit);
    return List<Map<String, dynamic>>.from(response);
  }

  // ========== الطلبات ==========
  static Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    final response = await client
        .from('orders')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // ========== الإشعارات ==========
  static Future<List<Map<String, dynamic>>> getNotifications(String userId, {int limit = 20}) async {
    final response = await client
        .from('notifications')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .limit(limit);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<void> markNotificationAsRead(String notificationId) async {
    await client.from('notifications').update({'is_read': true}).eq('id', notificationId);
  }
}
