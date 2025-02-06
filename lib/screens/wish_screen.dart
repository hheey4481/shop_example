import 'package:flutter/material.dart';
import 'package:shop_example/widgets/custom_app_bar.dart';

class WishScreen extends StatelessWidget {
  const WishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const Center(
        child: Text("Your Wishlist is Empty"),
      ),
    );
  }
}
