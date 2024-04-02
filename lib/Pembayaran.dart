import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';

class Bayar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F5F8),
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 18, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x320E151B),
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/1.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Produk',
                            style: TextStyle(
                              color: Color(0xFF0F1113),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Rp........',
                            style: TextStyle(
                              color: Color(0xFF57636C),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Jumlah: 1',
                            style: TextStyle(
                              color: Color(0xFF57636C),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            print('Edit button pressed...');
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Color(0xFF57636C),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            print('Delete button pressed...');
                          },
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: Color(0xFFDE4C62),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 210, // Atur tinggi bottom bar sesuai kebutuhan
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Total Pembelian',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF0F1113),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8), // Jarak antara "Price Breakdown" dan rincian harga
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jumlah',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '\Rp.....',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF0F1113),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              _buildTotal('Total:', '\Rp.100.00'),
              SizedBox(height: 20),
            
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kapkColor // Ubah warna latar belakang sesuai yang diinginkan
                  ),
                child: Text('Proceed to Payment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,

                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotal(String label, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
