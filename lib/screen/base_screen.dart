import 'package:starter_kit_app/routes/tabs_routers/home_tab_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:starter_kit_app/routes/tabs_routers/profile_tab_router.dart';
import 'package:starter_kit_app/routes/tabs_routers/shopping_tab_router.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  // final HomeController homeController = HomeController.to;

  final pageViewController = PageController();
  int _currentPage = 0;

  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = EdgeInsets.all(12);
  SnakeShape snakeShape = SnakeShape.indicator;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.white;
  Gradient selectedGradient =
      LinearGradient(colors: [Colors.red, Colors.amber]);

  Color unselectedColor = Colors.blueGrey;
  Gradient unselectedGradient =
      LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color containerColor;
  List<Color> containerColors = [
    Color(0xFFFDE1D7),
    Color(0xFFE4EDF5),
    Color(0xFFF4E4CE),
    Color(0xFFE7EEED),
  ];

  @override
  void initState() {
    _currentPage = 0;
    pageViewController.addListener(() {
      setState(() {
        _currentPage = pageViewController.page.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        child: PageView(
          controller: pageViewController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomeTabRouter(),
            ShoppingTabRouter(),
            ShoppingTabRouter(),
            ShoppingTabRouter(),
            ProfileTabRouter(),
          ],
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        elevation: 0,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        backgroundColor: Colors.black,
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        currentIndex: _currentPage,
        onTap: (index) => pageViewController.jumpToPage(index),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_outlined), label: 'calendar'),
          BottomNavigationBarItem(
              icon: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'microphone'),
        ],
      ),
    );
  }
}
