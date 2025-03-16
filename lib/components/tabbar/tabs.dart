import 'package:flutter/material.dart';

class BottomNavigationBarItems extends StatefulWidget {
  @override
  State<BottomNavigationBarItems> createState() => _BottomNavigationBarItemsState();
}
class _BottomNavigationBarItemsState extends State<BottomNavigationBarItems> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: Colors.red,
      currentIndex: _currentIndex,
      onTap: (index) {
        print(index);
        setState(() {
          _currentIndex = index;
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
    );
  }
}
