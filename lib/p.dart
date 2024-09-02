// import 'package:flutter/material.dart';

// class Coba extends StatefulWidget {
//   const Coba({super.key});

//   @override
//   State<Coba> createState() => _CobaState();
// }

// class _CobaState extends State<Coba> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Image Test')),
//       body: Image.network(
//         'http://localhost:8000/storage/images/1724580073.jpg', // Ganti dengan IP lokal Anda
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) {
//           print('Error loading image: $error'); // Log error ke konsol
//           return const Icon(
//               Icons.error); // Menangani kesalahan jika gambar tidak dimuat
//         },
//       ),
//     );
//   }
// }
