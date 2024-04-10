import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  List<String> selectedServices = [];

  List<String> services = ['Cukur Rambut', 'Chat Rambut', 'Creambath', 'Massage'];

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
                    _buildDateTimePicker("Pilih Tanggal :", Icons.calendar_today),
                    const SizedBox(height: 15.0),
                    _buildDateTimePicker("Pilih Waktu :", Icons.access_time),
                    const SizedBox(height: 15.0),
                    _buildServicesPicker(),
                    const SizedBox(height: 15.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Tambahkan fungsi yang sesuai ketika tombol ditekan
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF0E2954),
                          onPrimary: Colors.white,
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
            DateTime? pickedDate;
            TimeOfDay? pickedTime;
            if (icon == Icons.calendar_today) {
              pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2040),
              );
            } else {
              pickedTime = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
              );
            }

            if ((pickedDate != null && pickedDate != selectedDate) ||
                (pickedTime != null && pickedTime != selectedTime)) {
              setState(() {
                selectedDate = pickedDate ?? selectedDate;
                selectedTime = pickedTime ?? selectedTime;
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
                (icon == Icons.calendar_today && selectedDate != null)
                    ? ' ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                    : (icon == Icons.access_time && selectedTime != null)
                        ? ' ${selectedTime!.hour}:${selectedTime!.minute}'
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
            children: services.map((service) {
              return Card(
                color: selectedServices.contains(service) ? const Color(0xFF0E2954) : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.only(bottom: 5),
                child: ListTile(
                  title: Text(
                    service,
                    style: TextStyle(
                      color: selectedServices.contains(service) ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (selectedServices.contains(service)) {
                        selectedServices.remove(service);
                      } else {
                        selectedServices.add(service);
                      }
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
