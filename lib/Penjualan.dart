// ignore_for_file: unused_import

import 'package:apk_barbershop/Keranjang.dart';
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
                Navigator.pop(context);
              },
            ),
           
            flexibleSpace: AppbarBody(), 
          ),
        ),
      ),
      body: Produk(
        ProdukInfo: [
            Info(
            imagePath: 'assets/images/potong_rambut.jpg',
            title: 'Potong Rambut Dewasa',
            shortDescription: 'Harga Rp.50.000 ',
            fullDescription: 'Deskripsi lengkap untuk Product  yang ditampilkan di halaman detail.',
          ),
          Info(
            imagePath: 'assets/images/anak.jpg',
            title: 'Potong Rambut Anak',
           shortDescription: 'Harga Rp.30.000',
            fullDescription: 'Pengalaman potong rambut yang ramah dan nyaman untuk si kecil.',
          ),
         Info(
            imagePath: 'assets/images/cat_hitam.jpg',
            title: 'Cat Rambut Hitam',
           shortDescription: 'Harga Rp.100.000',
            fullDescription: 'Ubah rambut ubanmu menjadi rambut hitam berkilau',
          ),
           Info(
            imagePath: 'assets/images/cat_rambut.jpg',
            title: 'Cat Warna Bleaching 1',
            shortDescription: 'Harga Rp.200.000',
            fullDescription: 'Deskripsi lengkap untuk Product  yang ditampilkan di halaman detail.',
          ),
          Info(
            imagePath: 'assets/images/cat_rambut.jpg',
            title: 'Cat Warna Bleaching 2',
            shortDescription: 'Harga Rp.280.000',
            fullDescription: 'Deskripsi lengkap untuk Product  yang ditampilkan di halaman detail.',
          ),
          Info(
            imagePath: 'assets/images/creambath.jpg',
            title: 'Hair Creambath',
           shortDescription: 'Harga Rp.50.000',
            fullDescription: 'Deskripsi lengkap untuk Product 1 yang ditampilkan di halaman detail.',
          ),
            Info(
            imagePath: 'assets/images/cuci_rambut.jpg',
            title: 'Cuci Rambut',
            shortDescription: 'Harga Rp.15.000',
            fullDescription: 'Deskripsi lengkap untuk Product yang ditampilkan di halaman detail.',
          ),
            Info(
            imagePath: 'assets/images/cukur.jpg',
            title: 'Cukur',
            shortDescription: 'Harga Rp.25.000',
            fullDescription: 'Deskripsi lengkap untuk Product  yang ditampilkan di halaman detail.',
          ),
            Info(
            imagePath: 'assets/images/facial.jpg',
            title: 'Facial Wajah',
           shortDescription: '80.000',
            fullDescription: 'Deskripsi lengkap untuk Product  yang ditampilkan di halaman detail.',
          ),
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
            "Find your, \nFavorite Treatments !",
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
