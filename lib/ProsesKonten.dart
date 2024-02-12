import 'package:flutter/material.dart';

class ProsesKonten extends StatelessWidget {
  const ProsesKonten({Key? key}) : super(key: key);

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
                title: 'Cukur rambut',
                date: '24 Desember 2023',
                price: 50000,
              ),
              SizedBox(height: 30),
              Text(
                "PRODUK",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildProductPurchaseCard(
                status: 'Menunggu Pembayaran',
                products: ['Pomade Clay'],
                date: '01 Desember 2023',
                location: 'Balige',
                price: 120000,
              ),
              SizedBox(height: 20),
              _buildProductPurchaseCard(
                status: 'Proses',
                products: ['Powder Rambut'],
                date: '09 April 2023',
                location: 'Samosir',
                price: 75000,
              ),
              SizedBox(height: 20),
              ProsesContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard({
    required String title,
    required String date,
    required int price,
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
                Text('Rp$price'),
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

  Widget _buildProductPurchaseCard({
    required String status,
    required List<String> products,
    required String date,
    required String location,
    required int price,
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
                    color: Colors.blue,
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var product in products)
                  Text(
                    product,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                Text(date, style: TextStyle(fontSize: 12)),
                Text(location),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Pembayaran'),
                ),
                SizedBox(width: 8),
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

class ProsesContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Text(
                'Proses',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Powder Rambut',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '09 April 2023',
              style: TextStyle(fontSize: 12),
            ),
            Text('Samosir'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Terima Pesanan'),
                ),
                SizedBox(width: 8),
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
