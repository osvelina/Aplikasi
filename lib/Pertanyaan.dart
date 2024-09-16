import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';

class Pertanyaan extends StatefulWidget {
  const Pertanyaan({Key? key}) : super(key: key);

  @override
  State<Pertanyaan> createState() => _PertanyaanState();
}

class _PertanyaanState extends State<Pertanyaan> {
  // State variable to hold the search query
  String searchQuery = '';

  // List of FAQ items
  final List<Map<String, String>> faqs = [
    {
      'question': 'Bagaimana cara mendapatkan voucher ?',
      'answer':
          'Untuk mendapatkan voucher, Anda bisa mengikuti promo kami di aplikasi atau website.'
    },
    {
      'question': 'Dimana saja cabang Daeng Barbershop ?',
      'answer':
          'Cabang Daeng Barbershop tersebar di berbagai lokasi di kota. Silakan cek di halaman lokasi kami untuk detailnya.'
    },
    {
      'question': 'Gaya rambut yang cocok',
      'answer':
          'Kami menawarkan berbagai gaya rambut sesuai kebutuhan dan selera Anda. Anda dapat berkonsultasi dengan stylist kami untuk pilihan terbaik.'
    },
    {
      'question': 'Berdasarkan bentuk wajah',
      'answer':
          'Gaya rambut yang cocok bisa berbeda-beda tergantung bentuk wajah Anda. Konsultasikan dengan stylist kami untuk rekomendasi yang tepat.'
    },
    {
      'question': 'Berdasarkan tipe rambut',
      'answer':
          'Kami memiliki berbagai gaya yang cocok untuk berbagai tipe rambut. Jangan ragu untuk bertanya kepada stylist kami tentang gaya yang sesuai untuk rambut Anda.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kapkColor, // Lighter background color
      appBar: AppBar(
        backgroundColor: kapkColor, // Darker app bar color
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              iconSize: 30.0,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ada Pertanyaan tentang Daeng Barbershop? Tanyakan kepada kami di bawah ini',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'RadioCanada',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase(); // Update search query
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari Pertanyaan...',
                  prefixIcon: Icon(Icons.search, color: kapkColor),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "FAQ",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              ...buildFilteredListTiles(),
              SizedBox(height: 20), // Add space before the button container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Masih perlu bantuan? Hubungi kami di WhatsApp',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          // Add functionality here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kapkColor, // Matching button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                        ),
                        child: Text(
                          'Kirim Pesan',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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

  // Build the list tiles based on the search query
  List<Widget> buildFilteredListTiles() {
    final filteredFaqs = faqs.where((faq) {
      return faq['question']!.toLowerCase().contains(searchQuery);
    }).toList();

    return filteredFaqs
        .map((faq) => buildListTile(faq['question']!, faq['answer']!))
        .toList();
  }

  Widget buildListTile(String question, String answer) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Outfit',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: kapkColor,
          size: 30,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
