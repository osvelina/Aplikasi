import 'package:apk_barbershop/BerhasilDetail.dart';
import 'package:apk_barbershop/Request.dart';
import 'package:flutter/material.dart';
import 'ToPayDetail.dart';
import 'api_controller.dart'; // Import ApiController
import 'package:shared_preferences/shared_preferences.dart';

class ProsesKonten extends StatefulWidget {
  const ProsesKonten({Key? key}) : super(key: key);

  @override
  _ProsesKontenState createState() => _ProsesKontenState();
}

class _ProsesKontenState extends State<ProsesKonten> {
  final ApiController _apiController = ApiController();
  List<Map<String, dynamic>> _bookings = [];
  List<Map<String, dynamic>> jasaProducts = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadBookingProses();
  }

  Future<void> _loadBookingProses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final userId = prefs.getInt('userId');
      final selectedLocationId = prefs.getInt('id_lokasi');
      // final serviceName = prefs.getString('nama');

      if (accessToken == null || userId == null || selectedLocationId == null) {
        throw Exception("Access token, user ID, or location ID is null");
      }

      final bookings =
          await _apiController.getBookingProses(userId, selectedLocationId);
      setState(() {
        _bookings = bookings;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load booking history: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "BOOKING",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        ..._bookings.map((booking) => _buildProsesCard(
                              layanan: booking['layanan'],
                              status: booking['status'],
                              date: booking['tanggal_booking'],
                            )),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildProsesCard({
    required String layanan,
    required String status,
    required String date,
    // required VoidCallback? onTapPay,
    // required VoidCallback? onTapDetail,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _getStatusColor(status),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  layanan,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Detail'),
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'request':
        return Color.fromARGB(255, 146, 133, 14);
      case 'confirmed':
        return const Color.fromARGB(255, 63, 150, 66);
      case 'reserved':
        return const Color.fromARGB(255, 123, 33, 139);
      case 'Menunggu Pembayaran':
        return const Color.fromARGB(255, 37, 112, 173);
      default:
        return Colors.black;
    }
  }
}
