import 'package:flutter/material.dart';
import 'package:shop_example/data/products.dart';
import 'package:shop_example/models/product.dart';
import 'package:shop_example/screens/product_detail_screen.dart';
import 'package:shop_example/widgets/custom_app_bar.dart';

class RecentProductsScreen extends StatelessWidget {
  const RecentProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> recentProducts = dummyProducts;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView.builder(
        itemCount: recentProducts.length,
        itemBuilder: (context, index) {
          final product = recentProducts[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
            leading: Image.network(product.imageUrl, width: 50, height: 50),
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
