import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';

class Daerah extends StatefulWidget {
  const Daerah({Key? key}) : super(key: key);

  @override
  State<Daerah> createState() => _DaerahState();
}

class _DaerahState extends State<Daerah> {
  String _selectedCity = 'Kota Balige'; // Nilai default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                )
              ),
            ),
          ),
          Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 170), 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Pilih\nLokasi\nBarbershop',
                  style: TextStyle(
                    fontFamily: 'Outifit',
                    fontSize: 58,
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
                      value: _selectedCity,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCity = newValue!;
                        });
                      },
                      items: <String>[
                        'Kota Balige',
                        'Kota Tarutung',
                        'Kota Medan',
                        'Kota Jakarta'
                      ].map<DropdownMenuItem<String>>((String value) {
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
                      backgroundColor: primarybuttonColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      "SUBMIT",
                      style: WhiteTextStyle.copyWith(fontSize: 20, fontWeight: bold),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
