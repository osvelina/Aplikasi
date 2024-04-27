import 'package:apk_barbershop/ProductDetail.dart';
import 'package:flutter/material.dart';

class Produk extends StatelessWidget {
  final List<Info> ProdukInfo;

  const Produk({
    Key? key,
    required this.ProdukInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      crossAxisCount: 2,
      shrinkWrap: true,
      children: List.generate(
        ProdukInfo.length,
        (index) => InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetail(
                  imagePath: ProdukInfo[index].imagePath,
                  title: ProdukInfo[index].title,
                  fullDescription: ProdukInfo[index].fullDescription,
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blueGrey,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Image.asset(
                    ProdukInfo[index].imagePath,
                    height: 130,
                    width: 150,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ProdukInfo[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF0E2954),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        ProdukInfo[index].shortDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF0E2954),
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Info {
  final String imagePath;
  final String title;
  final String shortDescription;
  final String fullDescription;
  

  Info({
    required this.imagePath,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    
  });
}


