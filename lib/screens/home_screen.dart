import 'package:flutter/material.dart';
import 'package:shop_example/data/products.dart';
import 'package:shop_example/models/product.dart';
import 'package:shop_example/screens/product_list_screen.dart';
import 'package:shop_example/widgets/custom_carosel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 랜덤 추천 상품 4개 선택
    final List<Product> recommendedProducts = [...dummyProducts]..shuffle();
    final List<Product> displayedProducts =
        recommendedProducts.take(4).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop Example',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.list, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductListScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            CustomCarousel(
              imageUrls: displayedProducts.map((p) => p.imageUrl).toList(),
              names: displayedProducts.map((p) => p.name).toList(),
              prices: displayedProducts.map((p) => p.price).toList(),
            ),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recommended',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Text(
                      'For You',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
