import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/providers/cart_provider.dart';
import 'package:shop_example/screens/product_detail_screen.dart';
import 'package:shop_example/widgets/custom_app_bar.dart';
import 'package:shop_example/models/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: cartProvider.cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your Cart is Empty",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final Product product = cartProvider.cartItems[index];

                return ListTile(
                    leading:
                        Image.network(product.imageUrl, width: 50, height: 50),
                    title: Text(product.name),
                    subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      onPressed: () {
                        cartProvider.removeFromCart(product);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product),
                        ),
                      );
                    });
              },
            ),
    );
  }
}
