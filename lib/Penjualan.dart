import 'package:apk_barbershop/Produk.dart';
import 'package:flutter/material.dart';

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200), // Tentukan tinggi app bar
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0E2954), // Ubah warna latar belakang menjadi putih
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            boxShadow: [ 
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), 
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, 
            elevation: 0, 
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white), // Warna ikon putih
              onPressed: () {
                // Aksi yang akan dilakukan saat tombol back ditekan
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white), // Warna ikon putih
                onPressed: () {
                  // Aksi yang akan dilakukan saat tombol keranjang belanja ditekan
                },
              ),
            ],
            flexibleSpace: AppbarBody(), // memanggil isian appbar
          ),
        ),
      ),
     body: Produk(
     imagePaths: [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
    'assets/images/7.jpg',
  ],
),

    );
  }
}

class AppbarBody extends StatelessWidget {
  const AppbarBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Find your, \nFavorite Items!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
              color: Colors.white, 
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft, 
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200], 
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      cursorHeight: 20,
                      autofocus: false,
                      cursorColor: Colors.black, 
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search, color: Colors.black), 
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Colors.white, 
                radius: 17,
                child: Icon(Icons.filter_list, color: Colors.black), 
              ),
            ],
          ),
        ],
      ),
    );
  }
}
