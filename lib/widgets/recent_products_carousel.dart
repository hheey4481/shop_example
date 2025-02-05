import 'package:flutter/material.dart';

class RecentProductsCarousel extends StatelessWidget {
  final List<String> imageUrls;
  final VoidCallback onMorePressed;
  final Function(int index) onItemTap;

  const RecentProductsCarousel({
    super.key,
    required this.imageUrls,
    required this.onMorePressed,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 50,
            right: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recently Viewed',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              IconButton(
                onPressed: onMorePressed,
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onItemTap(index),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrls[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
