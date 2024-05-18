import 'package:flutter/material.dart';
import 'api_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Footer.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedServiceName; //tambahan
  int? selectedService; // Ubah tipe data selectedService menjadi int?
  List<Map<String, dynamic>> jasaProducts = [];
  final ApiController _apiController = ApiController();

  @override
  void initState() {
    super.initState();
    _loadJasaProducts();
  }

  Future<void> _loadJasaProducts() async {
    try {
      List<Map<String, dynamic>> products =
          await _apiController.getJasaProducts();
      setState(() {
        jasaProducts = products;
      });
    } catch (e) {
      print("Failed to load services: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E2954),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color(0xFF0E2954),
        title: const Text(
          "Hello....",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Book Your Date Today",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateTimePicker(
                        "Pilih Jadwal :", Icons.calendar_today),
                    const SizedBox(height: 15.0),
                    _buildServicesPicker(),
                    const SizedBox(height: 15.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          final selectedLocationId = prefs.getInt('id_lokasi');

                          if (selectedDate != null &&
                              selectedService != null &&
                              selectedServiceName != null && //tambahan
                              selectedLocationId != null) {
                            try {
                              final userId =
                                  await SharedPreferences.getInstance()
                                      .then((prefs) => prefs.getInt('userId'));
                              final accessToken =
                                  await _apiController.getToken();
                              if (accessToken == null) {
                                print('Access token not found');
                                return;
                              }

                              if (userId == null) {
                                throw Exception("User ID is null");
                              }

                              // Print the values before calling bookAppointment
                              print('selectedDate: $selectedDate');
                              print('selectedService: $selectedService');
                              print('userId: $userId');
                              print('locationId: $selectedLocationId');

                              await _apiController.bookAppointment(
                                context,
                                selectedDate!,
                                selectedService!,
                                userId,
                                selectedLocationId,
                                // selectedServiceName!,
                              );

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Success"),
                                    content: Text(
                                        "Book berhasil, menunggu konfirmasi server"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Footer()),
                                            (route) => false,
                                          );
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } catch (e) {
                              // Print the error to the console
                              print('Error: $e');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Failed to book "),
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please fill all fields"),
                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'BOOK',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
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
    );
  }

  Widget _buildDateTimePicker(String title, IconData icon) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8.0),
        OutlinedButton(
          onPressed: () async {
            DateTime? pickedDateTime;
            if (icon == Icons.calendar_today) {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2040),
              );
              if (pickedDate != null) {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime ?? TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  pickedDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                }
              }
            }

            if (pickedDateTime != null && pickedDateTime != selectedDate) {
              setState(() {
                selectedDate = pickedDateTime;
              });
            }
          },
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.blueGrey,
                size: 30,
              ),
              const SizedBox(width: 8.0),
              Text(
                (selectedDate != null)
                    ? ' ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} ${selectedDate!.hour}:${selectedDate!.minute}'
                    : '__ : __',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Layanan :',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: jasaProducts.map((product) {
              final serviceName = product['nama'];
              final productId = product['id_produk'];

              // Pastikan ini sesuai dengan struktur data dari API
              return Card(
                color: selectedService == productId
                    ? const Color(0xFF0E2954)
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.only(bottom: 5),
                child: ListTile(
                  title: Text(
                    serviceName,
                    style: TextStyle(
                      color: selectedService == productId
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedService = productId;
                      selectedServiceName = serviceName; //tambahan
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
