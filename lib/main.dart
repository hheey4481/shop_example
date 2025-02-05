import 'package:flutter/material.dart';
import 'package:shop_example/widgets/navigation_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shop',
      home: const NavigationItem(),
    );
  }
}
