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
      'color': Colors.blueGrey
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
                      "Hallo ${widget.userName ?? ''} ", // Gunakan userName yang sudah didapatkan
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
                          '', // Tampilkan lokasi yang dipilih, fallback ke 'Sidikalang'
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 7.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                height: 50,
                width: 350,
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
            SizedBox(height: 10),
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
                            highlightColor:
                                menuFavorite['color'].withOpacity(0.2),
                            onTap: () {
                              if (menuFavorite['route'] != null) {
                                Navigator.pushNamed(
                                    context, menuFavorite['route']);
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
                                              color: menuFavorite['color']
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(16),
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
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Spesial untuk kamu",
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold),
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
            // Placeholder untuk konten spesial
          ],
        ),
      ),
    );
  }
}

class HomePage2 extends StatelessWidget {
  final String imagePath;
  final String namevocher;
  final String rating;
  final String jamBuka;

  const HomePage2({
    Key? key,
    required this.imagePath,
    required this.namevocher,
    required this.rating,
    required this.jamBuka,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath),
        Text(namevocher),
        Text(rating),
        Text(jamBuka),
      ],
    );
  }
}
