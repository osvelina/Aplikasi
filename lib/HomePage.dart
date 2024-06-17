import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String? userName; // Properti userName
  const HomePage({Key? key, required this.userName}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName; // Tambahkan variabel userName
  String? locationName; // Variabel untuk menyimpan nama lokasi

  final List<Map> menuFavorites = [
    {
      'label': 'Booking',
      'image': 'assets/booking_image.png',
      'color': Colors.blueGrey,
      'route': '/Booking',
    },
    {
      'label': 'Layanan',
      'image': 'assets/produk_image.png',
      'color': Colors.blueGrey,
      'route': '/ECommerceApp',
    },
    {
      'label': 'Wilayah',
      'image': 'assets/more_image.png',
      'color': Colors.blueGrey,
      'route': '/AreaList',
    },
  ];

  @override
  void initState() {
    super.initState();
    _getUserName(); // Panggil fungsi _getUserName saat initState
    _getLocationName(); // Panggil fungsi _getLocationName saat initState
  }

  Future<void> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName =
          prefs.getString('userName'); // Ambil userName dari SharedPreferences
    });
  }

  Future<void> _getLocationName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      locationName = prefs.getString('selectedLocationName');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hallo ${widget.userName ?? ''} ", // Gunakan userName yang sudah didapatkan
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Selamat Datang !",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 65),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Point: 100 ", // Tampilkan "Point: "
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.place_outlined,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 3.0),
                                Text(
                                  locationName ??
                                      '', // Tampilkan lokasi yang dipilih
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 8.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
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
                                  splashColor:
                                      menuFavorite['color'].withOpacity(0.4),
                                  highlightColor:
                                      menuFavorite['color'].withOpacity(0.2),
                                  onTap: () {
                                    if (menuFavorite['route'] != null) {
                                      Navigator.pushNamed(
                                          context, menuFavorite['route']);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 15, 10, 6),
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
                                                    color: menuFavorite['color']
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
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
                                        Text(
                                          menuFavorite['label'],
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Outfit',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  );
                } else if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Spesial Untuk Kamu",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                } else if (index == 2) {
                  return HomePage2(
                    imagePath: "assets/feeds1.jpg",
                    namevocher: "BARBERKU",
                    description: "Dapatkan promo ini !!",
                  );
                } else if (index == 3) {
                  return HomePage2(
                    imagePath: "assets/feeds2.jpg",
                    namevocher: "BARBERKU",
                    description: "Dapatkan promo ini !!",
                  );
                } else if (index == 4) {
                  return HomePage2(
                    imagePath: "assets/feeds3.jpg",
                    namevocher: "BARBERKU",
                    description: "Dapatkan promo ini !!",
                  );
                }
                return null;
              },
              childCount: 5, // Jumlah total item dalam list
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage2 extends StatelessWidget {
  final String imagePath;
  final String namevocher;
  final String description;

  const HomePage2({
    Key? key,
    required this.imagePath,
    required this.namevocher,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0), // Jarak vertikal antara setiap card
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: InkWell(
            onTap: () {
              // logika jika di tap
            },
            child: Stack(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Tambahkan ini agar teks sejajar ke kiri
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: Image.asset(imagePath, fit: BoxFit.cover),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0), // Tambahkan padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Pastikan teks di dalam kolom ini juga sejajar kiri
                          children: [
                            Text(
                              namevocher, // Ganti dengan nama toko
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              description, // Ganti dengan deskripsi
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
