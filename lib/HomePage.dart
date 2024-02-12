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
      'label': 'booking',
      'image': 'assets/booking_image.png',
      'color': Colors.blueGrey
    },

    {
      'label': 'Voucher',
      'image': 'assets/voucher_image.png',
      'color': Colors.blueGrey
    },
    {
      'label': 'Produk',
      'image': 'assets/produk_image.png',
      'color': Colors.blueGrey
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Atas
              Stack(
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    color: const Color(0xFF0E2954),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  'assets/prabowo.jpg', // Mengubah path gambar
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Hallo Daniel,\nSelamat Datang !",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            cursorHeight: 20,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: "Cari Layanan",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Bagian GridView
              SizedBox(
                height: 15,
              ),
             Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    runSpacing: 8,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      for (final menuFavorite in menuFavorites) Material(
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          splashColor: menuFavorite['color'].withOpacity(0.4),
                          highlightColor: menuFavorite['color'].withOpacity(0.2),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          height: 60,
                                          width: 60,
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
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(menuFavorite['label'])
                              ],
                            ),
                          ),
                        )
                      ),
                    ],
                  )
                ],
              ),  // Gantilah "YourChildWidget()" dengan widget yang sesuai
            ),
            ],
          ),
        ),
      ),
    );
  }
}
