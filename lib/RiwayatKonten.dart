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
      final selectedLocationId = prefs.getInt('id_lokasi');

      if (accessToken == null || userId == null || selectedLocationId == null) {
        throw Exception("Access token, user ID, or location ID is null");
      }

      final bookings =
          await _apiController.getBookingHistory(userId, selectedLocationId);
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

  Widget _buildRiwayatCard({
    required String layanan,
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
      case 'cancelled':
        return Color.fromARGB(255, 120, 21, 12);
      case 'finished':
        return const Color.fromARGB(255, 63, 150, 66);
      case 'rejected':
        return const Color.fromARGB(255, 123, 33, 139);
      case 'Menunggu Pembayaran':
        return const Color.fromARGB(255, 37, 112, 173);
      default:
        return Colors.black;
    }
  }
}
