import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(200.0); // sesuaikan dengan keinginan Anda

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        color: Colors.blue, // warna latar belakang Appbar
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top), // untuk menghindari overlay dengan status bar
            // Tambahan widget lain yang ingin Anda tambahkan ke dalam Appbar
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    final p0 = size.height * 0.9; // Ubah nilai ketinggian dari bagian atas yang lebih tinggi
    path.lineTo(0.0, p0);

    final controlPoint = Offset(size.width * 0.5, size.height);
    final endPoint = Offset(size.width, p0);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
