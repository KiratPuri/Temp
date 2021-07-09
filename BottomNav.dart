import 'package:flutter/material.dart';
import 'Home.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    Home(),
    Home(),
    Home(),
    Home(),
    Home(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        backgroundColor: Color(0xFF0D83D9),
        selectedItemColor: Color(0xFFF8E64F),
        unselectedItemColor: Color(0xFF000000),
        selectedFontSize: 16,
        unselectedFontSize: 15,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.padding_rounded),
            label: 'Your Plan',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.medication_sharp), label: 'Consult'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
