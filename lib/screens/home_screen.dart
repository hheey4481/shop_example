import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.store,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        title: const Text(
          'Shop Example',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
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
                    fontSize: 38,
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
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(179, 94, 94, 94),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    textStyle:
                        const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  child: Text("All of Products"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
