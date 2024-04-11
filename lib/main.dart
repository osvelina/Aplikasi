// ignore_for_file: unused_import
import 'package:apk_barbershop/1.dart';
import 'package:apk_barbershop/Request.dart';
import 'package:apk_barbershop/Berhasil.dart';
import 'package:apk_barbershop/Daerah.dart';
import 'package:apk_barbershop/Register.dart';
import 'package:apk_barbershop/EditProfil.dart';
import 'package:apk_barbershop/Pembayaran.dart';
import 'package:apk_barbershop/Pertanyaan.dart';
import 'package:apk_barbershop/Booking.dart';
import 'package:apk_barbershop/DetailVoucher.dart';
import 'package:apk_barbershop/Footer.dart';
import 'package:apk_barbershop/HomePage.dart';
import 'package:apk_barbershop/LoginPage.dart';
import 'package:apk_barbershop/Penjualan.dart';
import 'package:apk_barbershop/Percobaan.dart';
import 'package:apk_barbershop/Profil.dart';
import 'package:apk_barbershop/Riwayat.dart';
import 'package:apk_barbershop/ToPay.dart';
import 'package:apk_barbershop/Voucher.dart';
import 'package:apk_barbershop/Produk.dart';
import 'package:apk_barbershop/ProductDetail.dart';
import 'package:apk_barbershop/Keranjang.dart';
import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       builder: EasyLoading.init(),
      initialRoute: '/', 
      routes: {
      '/': (context) => LoadingScreen(), 
        '/Booking': (context) => Booking(),
        '/Detail_': (context) => Voucher(),
        '/ECommerceApp': (context) => ECommerceApp(),

       } 

    );
  }
  
  

}
