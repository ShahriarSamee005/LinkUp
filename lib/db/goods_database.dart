import 'package:link_up/Auth/aut_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoodsDatabase {
  final goodsTable = Supabase.instance.client.from('goods');
  final authService = AuthService();

  Future<void> insertGoods({
  required String title,
  required String description,
  required double price,
  required String imageUrl,
}) async {
    final uid = authService.getCurrentUserUid();
    await goodsTable.insert({
      'user_id': uid,
      'title': title,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateGoods({
  required dynamic id,
  String? title,
  String? description,
  double? price,
  String? imageUrl,
}) async {
    final uid = authService.getCurrentUserUid();
  if (uid == null) throw Exception("No authenticated user found");
    final Map<String, dynamic> updates = {};
    if (title != null) updates['title'] = title;
    if (description != null) updates['description'] = description;
    if (price != null) updates['price'] = price;
    if (imageUrl != null) updates['image_url'] = imageUrl;

    if (updates.isNotEmpty) {
      await goodsTable.update(updates).eq('id', id);
    }
  }

Future<void> deleteGoods(dynamic id) async {
  final uid = authService.getCurrentUserUid();
  if (uid == null) throw Exception("No authenticated user found");

  await goodsTable
      .delete()
      .eq('id', id)
      .eq('user_id', uid); 
}

  Future<List<Map<String, dynamic>>> getAllGoods() async {
    final response = await goodsTable.select().order('created_at', ascending: false);
    final data = response as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }
}
