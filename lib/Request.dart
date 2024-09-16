import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';

class Request extends StatelessWidget {
  final String namaProduk;
  final String hargaProduk;
  final String date;

  Request({
    required this.namaProduk,
    required this.hargaProduk,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kapkColor,
      appBar: AppBar(
        backgroundColor: kapkColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RequestIcon(),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Permintaan Diproses",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RadioCanada',
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[50],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            namaProduk,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tanggal Booking",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            date,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Harga",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            hargaProduk,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.add_circle,
      color: Colors.white,
      size: 70.0,
    );
  }
}
