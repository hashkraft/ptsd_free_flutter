import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: BottomNavigationBar(
          selectedItemColor: HexColor("#19224C"),
          unselectedItemColor: HexColor("#A3A7B7"),
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          elevation: 10.0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.stop_circle), label: "Stopper"),
            BottomNavigationBarItem(
                icon: Icon(Icons.hearing_outlined), label: "Resolve"),
            BottomNavigationBarItem(
                icon: Icon(Icons.mediation_outlined), label: "My Meds"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
            BottomNavigationBarItem(icon: Icon(Icons.more), label: "Settings"),
          ]),
    );
  }
}
