import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String selectedRegion = 'Jakarta'; // Initial dropdown value
  DateTime? selectedDate; // Tanggal
  TimeOfDay? selectedTime; // waktu
  List<String> selectedServices = [];

  List<String> regions = ['Balige', 'Sidikalang', 'Tarutung', 'Medan', 'Jakarta'];
  List<String> services = ['Cukur Rambut', 'Chat Rambut', 'Creambath', 'Massage'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E2954),
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back,
        size: 28,
        color:Colors.white,),
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
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pilih Daerah Anda :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    DropdownButton<String>(
                      value: selectedRegion,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRegion = newValue!;
                        });
                      },
                      isDense: false,
                      isExpanded: true,
                      items: regions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 15.0, width: 8.0),
                    Row(
                      children: [
                        Text(
                          'Pilih Tanggal :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        OutlinedButton(
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2040),
                            );

                            if (pickedDate != null && pickedDate != selectedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.blueGrey,
                                size: 30,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                selectedDate != null
                                    ? ' ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                    : '_ /_ /____',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0, width: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Pilih Waktu :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        OutlinedButton(
                          onPressed: () async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime ?? TimeOfDay.now(),
                            );

                            if (pickedTime != null && pickedTime != selectedTime) {
                              setState(() {
                                selectedTime = pickedTime;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.blueGrey,
                                size: 30,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                selectedTime != null
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
                    ),
                    const SizedBox(height: 15.0, width: 15.0),
                    Text(
                      'Pilih Layanan :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          final service = services[index];
                          return Card(
                            color: selectedServices.contains(service) ? const Color(0xFF0E2954) : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0), // Mengatur sudut bulat
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
                        },
                      ),
                    ),
                   const SizedBox(height: 15.0),
                   Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Tambahkan fungsi yang sesuai ketika tombol ditekan
                        },
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: const Color(0xFF0E2954), 
                          // ignore: deprecated_member_use
                          onPrimary: Colors.white, 
                          elevation: 10.0, 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), 
                          ),
                        ),
                        child: Text(
                          'BOOK',
                          style: TextStyle(
                            fontSize: 18.0, // Ukuran font
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
}
