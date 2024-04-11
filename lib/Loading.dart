import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // EasyLoading.show(status: 'Loading...'); // Menampilkan loading indicator
      // // Proses memuat data
      await Future.delayed(Duration(seconds: 3));
      // Navigasi ke halaman selanjutnya setelah data dimuat
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // Tangani kesalahan jika terjadi
      EasyLoading.showError('Coba Ulang Sekali Lagi'); // Menampilkan pesan kesalahan
    } finally {
      EasyLoading.dismiss(); // Menutup loading indicator setelah proses selesai
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E2954),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100, 
              width: 100, 
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white), 
                strokeWidth: 10, 
              ),
            ),
            SizedBox(
              height: 20, 
            ),
            Text(
              'Tunggu Sebentar\nPermintaanmu Sedang Diproses',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'RadioCanada',
                fontSize: 25,
                ), // Warna teks putih
            ),
          ],
        ),
      ),
    );
  }
}
