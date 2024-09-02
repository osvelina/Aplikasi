import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_controller.dart';
import 'Footer.dart';

class Daerah extends StatefulWidget {
  const Daerah({Key? key}) : super(key: key);

  @override
  State<Daerah> createState() => _DaerahState();
}

class _DaerahState extends State<Daerah> {
  late String _selectedCity = '';
  // late int _selectedLocationId;
  late List<Map<String, dynamic>> _locations = [];
  late List<String> _locationNames = [];
  final ApiController _apiController = ApiController();

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    try {
      _locations = await _apiController.getLocations();
      _locationNames =
          _locations.map((location) => location['nama'] as String).toList();
      setState(() {});
    } catch (e) {
      print('Error loading locations: $e');
    }
  }

  void _submitLocation(BuildContext context) async {
    if (_selectedCity.isEmpty) {
      print('No city selected');
      return;
    }

    final selectedLocation = _locations.firstWhere(
      (location) => location['nama'] == _selectedCity,
      orElse: () => <String, dynamic>{},
    );

    if (selectedLocation.isEmpty) {
      print('Selected city not found in locations');
      return;
    }

    try {
      final selectedLocationName = selectedLocation['nama'] as String;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedLocationName', selectedLocationName);

      final selectedLocationId = selectedLocation['id_lokasi'] as int;
      await prefs.setInt('id_lokasi', selectedLocationId);
      final userId = prefs.getInt('userId');
      if (userId == null) {
        print('User ID is null');
        return;
      }

      // Get access token from SharedPreferences
      final accessToken = await _apiController.getToken();
      if (accessToken == null) {
        print('Access token not found');
        return;
      }

      // Set user location using API controller
      await _apiController.setUserLocation(
        accessToken: accessToken,
        userId: userId,
        locationId: selectedLocationId,
      );
      print('Location successfully set. LocationId: $selectedLocationId');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Footer()),
      );
    } catch (e) {
      print('Error submitting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Menentukan ukuran teks berdasarkan lebar dan tinggi layar
    double fontSize = (screenWidth * 0.050) + (screenHeight * 0.054);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Depan.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 170),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Pilih\nLokasi\nBarbershop',
                    style: TextStyle(
                      fontFamily: 'Outifit',
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _selectedCity.isEmpty ? null : _selectedCity,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCity = newValue ?? '';
                          });
                        },
                        items: _locationNames
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Icon(Icons.maps_home_work),
                                SizedBox(width: 8),
                                Text(value),
                              ],
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: _selectedCity.isEmpty
                            ? null
                            : () {
                                _submitLocation(context);
                              },
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
