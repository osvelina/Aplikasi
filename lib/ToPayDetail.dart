// import 'package:apk_barbershop/constant.dart';
// import 'package:flutter/material.dart';

// class ToPay extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),

//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TransactionSuccessIcon(),
//               ],
//             ),

//             SizedBox(height: 10),
//               Text(
//                 "Menunggu Pembayaran",
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 24),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.grey[50],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(30.10 ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "CODE BOOKING",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         "No. ANTRIAN",
//                         style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//                       ),
//                       Divider(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Cukur Rambut",
//                             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Tanggal Booking ",
//                             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "24 Desember 2023",
//                             style: TextStyle(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                        SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Harga",
//                             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "Rp 50.000",
//                             style: TextStyle(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                   width: double.infinity,
//                   height: 50,
//                   margin: EdgeInsets.symmetric(horizontal: 20),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                     ),
//                     onPressed: () {},
//                     child: Text(
//                       "BAYAR",
//                       style: WhiteTextStyle.copyWith(fontSize: 18, fontWeight: bold),
//                     ),
//                   ),
//                 ),
              
//             ]
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TransactionSuccessIcon extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Icon(
//       Icons.payment,
//       color: Colors.blue,
//       size: 70.0,
//     );
//   }
// }