import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_controller.dart';
import 'BerhasilDetail.dart';
import 'Request.dart';
import 'ToPayDetail.dart';

class ProsesKonten extends StatefulWidget {
  const ProsesKonten({Key? key}) : super(key: key);

  @override
  _ProsesKontenState createState() => _ProsesKontenState();
}

class _ProsesKontenState extends State<ProsesKonten> {
  final ApiController _apiController = ApiController();
  List<Map<String, dynamic>> _bookings = [];
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

      if (accessToken == null || userId == null) {
        throw Exception("Access token or user ID is null");
      }

      final bookings = await _apiController.getBookingProcess(userId);
      setState(() {
        _bookings = bookings;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load booking process: $e';
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
                              namaProduk: booking['nama_produk'],
                              hargaProduk: booking['harga_produk'],
                              status: booking['status'],
                              date: booking['tanggal_booking'],
                              bookingId: booking['id_booking'],
                            )),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildProsesCard({
    required String namaProduk,
    required String hargaProduk,
    required String status,
    required String date,
    required int bookingId,
  }) {
    String statusMessage;
    switch (status) {
      case 'request':
        statusMessage = 'Menunggu konfirmasi server';
        break;
      case 'confirmed':
        statusMessage = 'Segera lakukan pembayaran';
        break;
      case 'reserved':
        statusMessage = 'Segera datang ke barbershop';
        break;
      default:
        statusMessage = '';
        break;
    }

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
              children: [
                Expanded(
                  child: Text(
                    statusMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                if (status == 'request')
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Request(
                                  namaProduk: namaProduk,
                                  hargaProduk: hargaProduk,
                                  date: date,
                                )),
                      );
                    },
                    child: Text('Detail'),
                  )
                else if (status == 'confirmed')
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ToPay(
                                  bookingId: bookingId,
                                  namaProduk: namaProduk,
                                  hargaProduk: hargaProduk,
                                  date: date,
                                )),
                      );
                    },
                    child: Text('Pembayaran'),
                  )
                else if (status == 'reserved')
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Berhasil(
                                  namaProduk: namaProduk,
                                  hargaProduk: hargaProduk,
                                  date: date,
                                )),
                      );
                    },
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
        return const Color.fromARGB(255, 123, 33, 139);
      case 'reserved':
        return const Color.fromARGB(255, 63, 150, 66);
      default:
        return Colors.black;
    }
  }
}
