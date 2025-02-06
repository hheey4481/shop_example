import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shop_example/screens/cart_screen.dart';
import 'package:shop_example/screens/home_screen.dart';
import 'package:shop_example/screens/my_page_screen.dart';
import 'package:shop_example/screens/product_list_screen.dart';
import 'package:shop_example/screens/wish_screen.dart';

class NavigationItem extends StatefulWidget {
  const NavigationItem({super.key});

  @override
  NavigationItemState createState() => NavigationItemState();
}

class NavigationItemState extends State<NavigationItem> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CartScreen(),
    const ProductListScreen(),
    const WishScreen(),
    const MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.black,
        activeColor: Colors.white,
        color: Colors.grey,
        style: TabStyle.react,
        items: const [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.shopping_cart, title: "Cart"),
          TabItem(icon: Icons.list, title: "Products"),
          TabItem(icon: Icons.favorite, title: "Wish"),
          TabItem(icon: Icons.person, title: "My Page"),
        ],
        initialActiveIndex: 0,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
