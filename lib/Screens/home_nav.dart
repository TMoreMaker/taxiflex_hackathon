import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:provider/provider.dart';
import 'package:taxiflex/Screens/screens.dart';

import '../Services/services.dart';


class HomeNav extends StatefulWidget {
  const HomeNav({Key? key}) : super(key: key);

  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getRiderDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  int currentIndex = 0;
  final screens = [
    const MapScreen(),
     const PastOrdersScreen(),
    const AllRoutesScreen(),
    const QRScanScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SnakeNavigationBar.color(
        height: 60,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        snakeShape: SnakeShape.circle,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Past orders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded), label: 'All routes'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_rounded), label: 'Search')
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
    );
  }
}
