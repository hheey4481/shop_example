import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_example/models/cart_item.dart';
import 'package:shop_example/models/product.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  CartProvider() {
    _loadCartItems();
  }

  // 장바구니 불러오기
  Future<void> _loadCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cartData = prefs.getString('cart_items');

    if (cartData != null) {
      List<dynamic> decodedData = jsonDecode(cartData);
      _cartItems = decodedData.map((item) => CartItem.fromJson(item)).toList();
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
    int index = _cartItems.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      _cartItems[index].quantity += 1;
    } else {
      _cartItems.add(CartItem(product: product, quantity: 1));
    }

    _saveCartItems();
    notifyListeners();
  }

  // 장바구니 상품 삭제
  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
    _saveCartItems();
    notifyListeners();
  }

  // 장바구니 수량
  void decreaseQuantity(Product product) {
    int index = _cartItems.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity -= 1;
      } else {
        _cartItems.removeAt(index);
      }
      _saveCartItems();
      notifyListeners();
    }
  }

  // 장바구니 비우기
  void clearCart() {
    _cartItems.clear();
    _saveCartItems();
    notifyListeners();
  }
}
