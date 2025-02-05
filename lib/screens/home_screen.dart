import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_example/data/products.dart';
import 'package:shop_example/models/product.dart';
import 'package:shop_example/screens/product_detail_screen.dart';
import 'package:shop_example/screens/product_list_screen.dart';
import 'package:shop_example/screens/recent_products_screen.dart';
import 'package:shop_example/utils/recent_products.dart';
import 'package:shop_example/widgets/custom_app_bar.dart';
import 'package:shop_example/widgets/custom_carosel.dart';
import 'package:shop_example/widgets/recent_products_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _recentProductsFuture;

  @override
  void initState() {
    super.initState();
    _recentProductsFuture = RecentProducts.getRecentProducts();
  }

  @override
  Widget build(BuildContext context) {
    // 랜덤 추천 상품 4개 선택
    final List<Product> recommendedProducts = [...dummyProducts]..shuffle();
    final List<Product> displayedProducts =
        recommendedProducts.take(4).toList();

    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
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
                          builder: (context) => ProductListScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    child: const Text("All of Products"),
                  )
                ],
              ),
            ),
            const SizedBox(height: 80),
            // 최근 본 상품 (비동기 데이터 로딩)
            FutureBuilder<List<Product>>(
              future: _recentProductsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator()); // 로딩
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SizedBox.shrink();
                }

                // 최근 본 상품 4개 가져오기
                final List<Product> recentProducts =
                    snapshot.data!.take(4).toList();

                return RecentProductsCarousel(
                  imageUrls: recentProducts.map((p) => p.imageUrl).toList(),
                  onMorePressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecentProductsScreen(),
                      ),
                    );
                  },
                  onItemTap: (int index) {
                    final product = recentProducts[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
