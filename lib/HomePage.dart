import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
              ? content['image_path']
              : 'http://10.0.2.2:8000/assets/feeds1.jpg';
          return {
            ...content,
            'image_path': CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            pinned: true,
            leading: SizedBox.shrink(),
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
                        "Hallo ${widget.userName ?? ''}",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Selamat Datang!",
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  if (_isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (_errorMessage != null) {
                    return Center(child: Text('Error: $_errorMessage'));
                  }
                  if (index - 2 < _contents.length) {
                    final content = _contents[index - 2];
                    return HomePage2(
                      imagePath: 'http://10.0.2.2:8000${content['image_path']}',
                      title: content['title'],
                      description: content['description'],
                    );
                  } else {
                    return Center(child: Text('No content available'));
                  }
                }
              },
              childCount:
                  2 + _contents.length, // 2 untuk item statis + konten dari API
            ),
          ),
        ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        imagePath,
                        height: 140,
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
                      SizedBox(height: 10),
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
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
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
