import 'package:apk_barbershop/ProsesKonten.dart';
import 'package:apk_barbershop/RiwayatKonten.dart';
import 'package:flutter/material.dart';

class Riwayat extends StatelessWidget {
  const Riwayat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Riwayat'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // Sesuaikan tinggi sesuai kebutuhan
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Mengatur border radius
                  color: Colors.grey[200], // Mengatur warna latar belakang
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Mengatur border radius
                    color: Colors.greenAccent, // Mengatur warna latar belakang indikator
                  ),
                  indicatorSize: TabBarIndicatorSize.label, // Menyesuaikan lebar indikator dengan label
                  labelPadding: EdgeInsets.symmetric(horizontal: 8.0), // Menambahkan padding pada label
                  physics: NeverScrollableScrollPhysics(), // Menghilangkan animasi
                  tabs: [
                    _buildTab("Riwayat"),
                    _buildTab("Proses"),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(), // Menghilangkan animasi
          children: [
            RiwayatContent(), // Konten untuk tab Riwayat
            ProsesContent(), // Konten untuk tab Proses
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title) {
    return Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(title),
      ),
    );
  }
}

class ProsesContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProsesKonten();
  }
}

class RiwayatContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RiwayatKonten(
    );
  }
}