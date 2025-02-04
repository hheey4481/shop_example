import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  final List<String> imageUrls; // 이미지 URL 리스트
  final List<String> names; // 상품 이름 리스트
  final List<double> prices; // 상품 가격 리스트

  const CustomCarousel({
    super.key,
    required this.imageUrls,
    required this.names,
    required this.prices,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 300, // 일반적인 상품 추천 슬라이더 높이
        autoPlay: true, // 자동 슬라이드
        enlargeCenterPage: true, // 중앙 강조 효과
        // viewportFraction: 0.8, // 이미지 비율 조정
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index, realIndex) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrls[index],
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      names[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${prices[index].toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
