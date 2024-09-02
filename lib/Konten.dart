import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage2 extends StatelessWidget {
  final String imagePath;
  final String namevocher;
  final String rating;
  final String jamBuka;

  const HomePage2({
    Key? key,
    required this.imagePath,
    required this.namevocher,
    required this.rating,
    required this.jamBuka,
    required title,
    required description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0), // Jarak vertikal antara setiap card
      child: SizedBox(
        width: double.infinity,
        height: 230,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            onTap: () {
              // logika jika di tap
            },
            child: Stack(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: Image.asset(imagePath, fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              namevocher, // Ganti dengan nama toko
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.favorite, color: Colors.red),
                                SizedBox(width: 5),
                                Text(
                                  'Like', // Ganti dengan nilai rating
                                  style: GoogleFonts.montserrat(fontSize: 12),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
