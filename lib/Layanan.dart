import 'package:flutter/material.dart';
import 'package:apk_barbershop/api_controller.dart';
import 'package:apk_barbershop/Produk.dart';

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Info>>(
      future: ApiController().getProdukByJenis(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}'); // Print error details
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Scaffold(
              body: Center(child: Text('No data available')),
            );
          }
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(200),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0E2954),
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
                  leading: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  flexibleSpace: AppbarBody(),
                ),
              ),
            ),
            body: Produk(ProdukInfo: snapshot.data!),
          );
        } else {
          return Scaffold(
            body: Center(child: Text('No data available')),
          );
        }
      },
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
