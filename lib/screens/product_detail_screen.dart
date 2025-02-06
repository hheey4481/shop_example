import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/models/product.dart';
import 'package:shop_example/providers/cart_provider.dart';
import 'package:shop_example/utils/recent_products.dart';
import 'package:shop_example/widgets/custom_app_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    RecentProducts.addProduct(product);

    bool isWish = false;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 80, bottom: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(product.imageUrl, height: 250, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text(
                product.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      final cartProvider =
                          Provider.of<CartProvider>(context, listen: false);
                      cartProvider.addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} added to cart'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isWish = !isWish;
                        }); // wish toggle

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isWish
                                ? '${product.name} added to your Wish'
                                : '${product.name} removed to your Wish'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.favorite,
                        size: 18,
                        color: isWish ? Colors.red : Colors.grey,
                      ),
                      label: Text(
                        'Wish',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
