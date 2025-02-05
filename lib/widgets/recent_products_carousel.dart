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
    final List<String?> displayList = List<String?>.filled(4, null);

    for (int i = 0; i < imageUrls.length && i < 4; i++) {
      displayList[i] = imageUrls[i];
    }

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
              itemCount: 4,
              itemBuilder: (context, index) {
                final imageUrl = displayList[index];

                return GestureDetector(
                  onTap: imageUrl != null ? () => onItemTap(index) : null,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: imageUrl == null
                          ? Colors.grey[300]
                          : null, // 빈 칸이면 회색
                      image: imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
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
