// ignore_for_file: duplicate_import

import 'package:apk_barbershop/HomePage.dart';
import 'package:flutter/material.dart';
import './Riwayat.dart';
import './HomePage.dart';
import './Profil.dart';

class footer extends StatefulWidget {
  const footer({super.key});

  @override
  State<footer> createState() => new _footerState();

}

class _footerState extends State<footer> {
    int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [new HomePage(), new Riwayat(), new Profil()];

  @override
  void initState() {
    super.initState();
  }
@override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: _container[_bottomNavCurrentIndex],
        bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _bottomNavCurrentIndex = index;
            });
          },
          currentIndex: _bottomNavCurrentIndex,
          items: [
            BottomNavigationBarItem(
              activeIcon: new Icon(
                Icons.home_filled,
                color: Color(0xFF0E2954),
              ),
              icon: new Icon(
                Icons.home,
                color: Colors.grey,
              ),
              label: 'Beranda'
            ),
            BottomNavigationBarItem(
              activeIcon: new Icon(
                Icons.history,
                color: Color(0xFF0E2954),
              ),
              icon: new Icon(
                Icons.assignment,
                color: Colors.grey,
              ),
              label:'Riwayat'
            ),

            BottomNavigationBarItem(
              activeIcon: new Icon(
                Icons.person_pin,
                color: Color(0xFF0E2954),
              ),
              icon: new Icon(
                Icons.people,
                color: Colors.grey,
              ),
              label: 'Profil'
            ),
          ],
        ));
  }
}