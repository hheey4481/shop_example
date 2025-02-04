import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_example/models/product.dart';

class RecentProducts {
  static const String _key = 'recent_products';

  static Future<void> addProduct(Product product) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> recentList = pref.getStringList(_key) ?? [];

    // 중복 제거 후 최신 항목 추가
    recentList.removeWhere((item) => jsonDecode(item)['id'] == product.id);
    recentList.insert(0, jsonEncode(product.toJson()));

    // 업데이트 리스트 저장
    await pref.setStringList(_key, recentList);
  }

  // 최근 본 상품 불러오기
  static Future<List<Product>> getRecentProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? recentList = prefs.getStringList(_key);

    if (recentList == null || recentList.isEmpty) return [];

    return recentList
        .map((item) => Product.fromJson(jsonDecode(item)))
        .toList();
  }
}
