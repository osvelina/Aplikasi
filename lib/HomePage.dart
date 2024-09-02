import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_controller.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  final String? userName;
  const HomePage({Key? key, required this.userName}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;
  String? locationName;
  String? point;
  List<Map<String, dynamic>> _contents = [];
  bool _isLoading = true;
  String? _errorMessage;

  final List<Map> menuFavorites = [
    {
      'label': 'Booking',
      'image': 'assets/booking_image.png',
      'route': '/Booking',
    },
    {
      'label': 'Layanan',
      'image': 'assets/produk_image.png',
      'route': '/ECommerceApp',
    },
    {
      'label': 'Wilayah',
      'image': 'assets/more_image.png',
      'route': '/AreaList',
    },
  ];

  @override
  void initState() {
    super.initState();
    _getUserName();
    _getLocationName();
    _getPoint();
    _fetchContents();
  }

  Future<void> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
    });
  }

  Future<void> _getLocationName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      locationName = prefs.getString('selectedLocationName');
    });
  }

  Future<void> _getPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      point = prefs.getString('point');
    });
  }

  Future<void> _fetchContents() async {
    try {
      print('Fetching contents...');
      ApiController apiController = ApiController();
      List<Map<String, dynamic>> contents = await apiController.getContents();
      print('Contents retrieved: $contents');
      setState(() {
        _contents = contents.map((content) {
          String imageUrl = content['image_path'].isNotEmpty
              ? '${content['image_path']}'
              : 'assets/feeds1.jpg';
          return {
            ...content,
            'image_path': imageUrl,
          };
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching contents: $e');
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 210,
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
                    SizedBox(height: 30),
                    Text(
                      "Hallo ${widget.userName?.split(' ').first ?? ''}",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Selamat Datang!",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Point: ${point ?? '0'}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
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
                                locationName ?? '',
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
                            highlightColor:
                                (menuFavorite['color'] ?? Colors.black)
                                    .withOpacity(0.2),
                            onTap: () {
                              if (menuFavorite['route'] != null) {
                                Navigator.pushNamed(
                                    context, menuFavorite['route']);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 10, 6),
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
                                              color: Color(0xFF0E2954),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            menuFavorite['image'],
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
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
            Container(
              alignment: Alignment.centerLeft, // Mengatur alignment ke kiri
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Mengatur teks dan elemen lainnya tetap ke kiri
                children: [
                  Text(
                    "Spesial Untuk Kamu",
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5), // Jarak antara teks dan garis bawah
                  Container(
                    height: 3, // Ketebalan garis
                    width: 100, // Panjang garis
                    color: kapkColor, // Warna garis
                  ),
                ],
              ),
            ),
            if (_isLoading) Center(child: CircularProgressIndicator()),
            if (_errorMessage != null)
              Center(child: Text('Error: $_errorMessage')),
            if (!_isLoading && _errorMessage == null)
              ..._contents
                  .map((content) => HomePage2(
                        imagePath: content['image_path'],
                        title: content['title'],
                        description: content['description'],
                      ))
                  .toList(),
          ],
        ),
      ),
    );
  }
}

class HomePage2 extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const HomePage2({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 350,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          imagePath,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/feeds2.jpg',
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                          ),
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
