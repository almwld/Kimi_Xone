import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final client = Supabase.instance.client;

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

  static Future<Map<String, dynamic>?> getUser(String userId) async {
    return await client.from('profiles').select().eq('id', userId).maybeSingle();
  }

  static Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await client.from('profiles').update(data).eq('id', userId);
  }

  static Future<Map<String, dynamic>?> getWallet(String userId) async {
    return await client.from('wallets').select().eq('user_id', userId).maybeSingle();
  }

  static Future<void> createWallet(String userId) async {
    await client.from('wallets').insert({'user_id': userId, 'yer_balance': 0, 'sar_balance': 0, 'usd_balance': 0});
  }

  static Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    final response = await client.from('orders').select().eq('user_id', userId).order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }
}
