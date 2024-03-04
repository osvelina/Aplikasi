import 'package:flutter/material.dart';

class Produk extends StatelessWidget {
  final List<String> imagePaths;

  const Produk({
    Key? key,
    required this.imagePaths,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GridView.count(
        childAspectRatio: 0.68,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(
          imagePaths.length,
          (index) => Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blueGrey,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "-50%",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    )
                  ],
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset(
                      imagePaths[index],
                      height: 90,
                      width: 90,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Judul Produk",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF0E2954),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tulis Deskripsi disini",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF0E2954),
                    ),         
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rp67.000",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0E2954)
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart_checkout,
                        color: Color(0xFF0E2954),
                      )
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
