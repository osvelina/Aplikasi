import 'package:flutter/material.dart';

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink, // Ubah warna menjadi pink
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Ubah warna ikon menjadi putih
          onPressed: () {
            // Aksi yang akan dilakukan saat tombol back ditekan
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white), // Ubah warna ikon menjadi putih
            onPressed: () {
              // Aksi yang akan dilakukan saat tombol pencarian ditekan
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white), // Ubah warna ikon menjadi putih
            onPressed: () {
              // Aksi yang akan dilakukan saat tombol keranjang belanja ditekan
            },
          ),
        ],
      ),
      body: UpperBody(),
    );
  }
}

class UpperBody extends StatefulWidget {
  const UpperBody({Key? key}) : super(key: key);

  @override
  State<UpperBody> createState() => _UpperBodyState();
}

class _UpperBodyState extends State<UpperBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white, // Ubah warna latar belakang menjadi putih
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [ // Tambahkan bayangan untuk efek visual
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Sesuaikan padding
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.black), // Ubah warna ikon menjadi hitam
                  onPressed: () {
                    // Aksi yang akan dilakukan saat tombol menu ditekan
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.black), // Ubah warna ikon menjadi hitam
                  onPressed: () {
                    // Aksi yang akan dilakukan saat tombol keranjang belanja ditekan
                  },
                ),
              ],
            ),
            SizedBox(height: 10), // Tambahkan spasi antara elemen
            Text(
              "Find your Favorite Items!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 27,
                color: Colors.black, // Ubah warna teks menjadi hitam
              ),
            ),
            SizedBox(height: 10), // Tambahkan spasi antara elemen
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Ubah warna latar belakang menjadi abu-abu
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        cursorColor: Colors.black, // Ubah warna kursor menjadi hitam
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search, color: Colors.black), // Ubah warna ikon menjadi hitam
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Tambahkan spasi antara elemen
                CircleAvatar(
                  backgroundColor: Colors.grey[200], // Ubah warna latar belakang menjadi abu-abu
                  radius: 17,
                  child: Icon(Icons.filter_list, color: Colors.black), // Ubah warna ikon menjadi hitam
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
