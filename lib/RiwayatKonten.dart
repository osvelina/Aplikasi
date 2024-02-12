import 'package:flutter/material.dart';

class RiwayatKonten extends StatelessWidget {
  const RiwayatKonten({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "BOOKING",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildBookingCard(
                status: 'Selesai',
                title: 'Cukur rambut',
                date: '24 Desember 2023',
                price: 'Rp...........',
              ),
              SizedBox(height: 30),
              Text(
                "PRODUK",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildProductPurchaseCard(
                productName: 'Pomade',
                date: '24 Desember 2023',
                location: 'Balige',
                price: 'Rp...........',
                status: 'Selesai',
              ),
              SizedBox(height: 20),
              _buildProductPurchaseCard(
                productName: 'Powder Rambut',
                date: '09 April 2023',
                location: 'Samosir',
                price: 'Rp...........',
                status: 'Dibatalkan',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard({
    required String title,
    required String date,
    required String price,
    required String status,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(price),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Detail'),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: status == 'Selesai' ? Colors.green : Colors.red,
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductPurchaseCard({
    required String productName,
    required String date,
    required String location,
    required String price,
    required String status,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: status == 'Selesai' ? Colors.green : Colors.red,
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      date,
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(location),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Detail'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RiwayatKonten(),
  ));
}
