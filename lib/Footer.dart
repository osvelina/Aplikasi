import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Riwayat.dart';
import './HomePage.dart';
import './Profil.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _bottomNavCurrentIndex = 0;
  String? userName;

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  // Function untuk mengambil userName dari SharedPreferences
  Future<void> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _container = [
      HomePage(
          userName: userName ??
              ''), // Menggunakan nilai userName yang sudah diambil atau default ''
      Riwayat(),
      Profile()
    ];

    return Scaffold(
      body: _container[_bottomNavCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomNavCurrentIndex = index;
          });
        },
        currentIndex: _bottomNavCurrentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home_filled,
              color: Color(0xFF0E2954),
            ),
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.history,
              color: Color(0xFF0E2954),
            ),
            icon: Icon(
              Icons.assignment,
              color: Colors.grey,
            ),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person_pin,
              color: Color(0xFF0E2954),
            ),
            icon: Icon(
              Icons.people,
              color: Colors.grey,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
