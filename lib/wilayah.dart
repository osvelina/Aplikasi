import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'api_controller.dart';

class Area {
  final String name;
  final String alamat;
  final String kota;
  final String kodepos;

  Area({
    required this.name,
    required this.alamat,
    required this.kota,
    required this.kodepos,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      name: json['nama'],
      alamat: json['alamat'],
      kota: json['kota'],
      kodepos: json['kodepos'],
    );
  }
}

class AreaList extends StatefulWidget {
  @override
  _AreaListState createState() => _AreaListState();
}

class _AreaListState extends State<AreaList> {
  late ApiController _apiController;
  late Future<List<Area>> _areasFuture;

  @override
  void initState() {
    super.initState();
    _apiController = ApiController();
    _areasFuture = _fetchAreas();
  }

  Future<List<Area>> _fetchAreas() async {
    try {
      final response = await _apiController.getLocations();
      return response.map((json) => Area.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching areas: $e');
      return [];
    }
  }

  void _openMaps(String address) async {
    final query = Uri.encodeComponent(address);
    final googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$query";
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      print('Could not open the URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Adjust height if necessary
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false, // Prevent default leading behavior
          title: Row(
            children: [
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                iconSize: 30.0, // Adjust size as needed
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 10), // Space between icon and title
              Expanded(
                child: Text(
                  'Daerah Barbershop',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          titleSpacing: 0, // Ensure no extra spacing
          toolbarHeight: 60, // Adjust height if necessary
        ),
      ),
      body: FutureBuilder<List<Area>>(
        future: _areasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load areas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No areas available'));
          }

          final areas = snapshot.data!;
          return ListView.builder(
            itemCount: areas.length,
            itemBuilder: (context, index) {
              final area = areas[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/crop.jpeg',
                      height: 50,
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            area.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            area.alamat,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap: () => _openMaps(area.alamat),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "${area.kota}, ${area.kodepos}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
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
              );
            },
          );
        },
      ),
    );
  }
}
