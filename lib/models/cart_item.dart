import 'package:shop_example/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(
          json['product']), // json에서 'product'를 꺼내서 Product 객체로 변환
      quantity: json['quantity'], // json에서 'quantity' 값을 그대로 가져옴
    );
  }
}
