import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_controller.dart';

class RiwayatKonten extends StatefulWidget {
  const RiwayatKonten({Key? key}) : super(key: key);

  @override
  _RiwayatKontenState createState() => _RiwayatKontenState();
}

class _RiwayatKontenState extends State<RiwayatKonten> {
  final ApiController _apiController = ApiController();
  List<Map<String, dynamic>> _bookings = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadBookingHistory();
  }

  Future<void> _loadBookingHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final userId = prefs.getInt('userId');

      if (accessToken == null || userId == null) {
        throw Exception("Access token or user ID is null");
      }

      final bookings = await _apiController.getBookingHistory(userId);
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
                        ..._bookings.map((booking) => _buildRiwayatCard(
                              namaProduk: booking['nama_produk'],
                              hargaProduk: booking['harga_produk'],
                              status: booking['status'],
                              date: booking['tanggal_booking'],
                            )),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildRiwayatCard({
    required String namaProduk,
    required String hargaProduk,
    required String status,
    required String date,
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
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  namaProduk,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Harga: $hargaProduk',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'cancelled':
        return Color.fromARGB(255, 120, 21, 12);
      case 'finished':
        return const Color.fromARGB(255, 63, 150, 66);
      case 'rejected':
        return const Color.fromARGB(255, 123, 33, 139);
      default:
        return Colors.black;
    }
  }
}
