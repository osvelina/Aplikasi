 
// ignore_for_file: unused_import

import 'package:apk_barbershop/Booking.dart';
import 'package:apk_barbershop/Card%20Homepage.dart';
import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map> menuFavorites = [
    {
      'label': 'Booking',
    'image': 'assets/booking_image.png',
    'color': Colors.blueGrey, 
    'route': '/Booking', 
    },

    // {
    //   'label': 'Voucher',
    //   'image': 'assets/voucher_image.png',
    //   'color': Colors.blueGrey,
    //   'route': '/Detail_',
    // },
    {
      'label': 'Produk',
      'image': 'assets/produk_image.png',
      'color': Colors.blueGrey,
      'route':'/ECommerceApp',
    },
    {
      'label': 'More',
      'image': 'assets/more_image.png',
      'color': Colors.blueGrey
    },
  ];
  



@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: whiteColor,
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 100),
      child: AppBar(
       
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpeg'),
              fit: BoxFit.cover,
            ),
              borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),     
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hallo Daniel, ",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Selamat Datang !",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20), // Tambahkan SizedBox untuk jarak
            IconButton(
              onPressed: () {
                // Tambahkan aksi yang diinginkan di sini
              },
              icon: Icon(Icons.notifications_active),
              color: Colors.white,
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60), // Sesuaikan dengan tinggi TextField + padding
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Sesuaikan dengan kebutuhan
            child: Container(
              height: 50,
              width: 350, // Atur lebar sesuai kebutuhan Anda
              child: TextField(
                cursorHeight: 20,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintText: 'Cari Layanan',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian GridView
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  runSpacing: 10,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    for (final menuFavorite in menuFavorites)
                      Material(
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          splashColor: menuFavorite['color'].withOpacity(0.4),
                          highlightColor: menuFavorite['color'].withOpacity(0.2),
                          onTap: () {
                            if (menuFavorite['route'] != null) {
                              Navigator.pushNamed(context, menuFavorite['route']);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: menuFavorite['color'].withOpacity(0.4),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          menuFavorite['image'],
                                          height: 45,
                                          width: 45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(menuFavorite['label'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Outfit',
                                ),)
                              ],
                            ),
                          ),
                          
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Spesial untuk kamu",
              style: GoogleFonts.montserrat(
                fontSize: 18, fontWeight: FontWeight.bold
              ),
              ),
              ),
              HomePage2(
              imagePath: "assets/feeds1.jpg",
              namevocher: "barberku",
              rating: "4.8",
              jamBuka: "10.00 - 23.00",
            ),
            HomePage2(
              imagePath: "assets/feeds2.jpg",
              namevocher: "barberku",
              rating: "4.9",
              jamBuka: "13.00 - 23.00",
            ),
            HomePage2(
              imagePath: "assets/feeds3.jpg",
              namevocher: "barberku",
              rating: "4.7",
              jamBuka: "13.00 - 20.00",
            ),

            

        ],
      ),
    ),
  );
}
}
