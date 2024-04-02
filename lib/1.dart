// import 'package:apk_barbershop/constant.dart';
// import 'package:flutter/material.dart';

// class Point extends StatefulWidget {
//   const Point({super.key});

//   @override
//   State<Point> createState() => _PointState();
// }

// class _PointState extends State<Point> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Point',
//         textAlign: TextAlign.center,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//           fontSize: 24,
//           fontWeight: bold,
          
//         ),),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back), 
//         onPressed: () {}),
        
//       ),
//       body: SingleChildScrollView(
//       child: RewardCard(),
//       ),
      
//       );
//   }
// }
// class RewardCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(20),
//       child: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Your Reward Points:',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               '1000 Points',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Colors.blue,
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Add onPressed function for redeeming points
//               },
//               child: Text('Redeem Points'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }