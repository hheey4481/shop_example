import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_example/models/product.dart';

class CartProvider with ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  CartProvider() {
    _loadCartItems();
  }

  // 장바구니 불러오기
  Future<void> _loadCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cartData = prefs.getString('cart_items');

    if (cartData != null) {
      List<dynamic> decodedData = jsonDecode(cartData);
      _cartItems = decodedData.map((item) => Product.fromJson(item)).toList();
      notifyListeners();
    }
  }

  // 장바구니 저장하기
  Future<void> _saveCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData =
        jsonEncode(_cartItems.map((item) => item.toJson()).toList());
    await prefs.setString(' cart_items', encodedData);
  }

  // 상품 추가
  void addToCart(Product product) {
    _cartItems.add(product);
    _saveCartItems();
    notifyListeners();
  }

  // TODO: 장바구니에 중복으로 담는 경우 id로 삭제하면 모두 삭제됨
  // 개수를 업데이트하도록 로직을 수정하면 이 문제도 해결될 것 같음
  // 상품 삭제
  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.id == product.id);
    _saveCartItems();
    notifyListeners();
  }

  // 장바구니 비우기
  void clearCart() {
    _cartItems.clear();
    _saveCartItems();
    notifyListeners();
  }
}
