import 'package:apk_barbershop/DetailVoucher.dart';
import 'package:flutter/material.dart';

class Voucher extends StatelessWidget {
  const Voucher({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E2954),
      appBar: AppBar(
              shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        backgroundColor: Colors.white,
        title: const Text(
          "Voucher",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Detail_();
                },
              );
            },
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.local_offer,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  'Voucher ${index + 1}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Diskon 20% untuk pembelanjaan minimal Rp 100.000',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Text(
                  'Rp 20.000',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
