import 'package:flutter/material.dart';

class Voucher extends StatelessWidget {
  const Voucher({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E2954),
      
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium (
            backgroundColor:  Colors.white,
            title: const Text(
              "Voucher",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            floating: true,
            pinned: true,
            snap: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailVoucherPage(),
                      //   ),
                      // );
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.local_offer,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Voucher ${index + 1}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Diskon 20% untuk pembelanjaan minimal Rp 100.000',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        'Rp 20.000',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
              childCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
