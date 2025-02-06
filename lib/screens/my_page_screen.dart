import 'package:flutter/material.dart';
import 'package:shop_example/widgets/custom_app_bar.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const Center(
        child: Text("User's page"),
      ),
    );
  }
}
