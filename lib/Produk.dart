import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';
import 'package:apk_barbershop/ProductDetail.dart';

class Produk extends StatefulWidget {
  final List<Info> ProdukInfo;

  const Produk({
    Key? key,
    required this.ProdukInfo,
  }) : super(key: key);

  @override
  _ProdukState createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
  List<Info> _filteredProdukInfo = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredProdukInfo = widget.ProdukInfo;
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProdukInfo = widget.ProdukInfo.where((product) =>
              product.nama.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.9, // 80% of the screen width
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              cursorHeight: 20,
              autofocus: false,
              cursorColor: Colors.black,
              textAlign: TextAlign.left,
              textAlignVertical:
                  TextAlignVertical.center, // Center the hint text
              onChanged: _updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Cari Layanan',
                hintStyle: TextStyle(color: kapkColor),
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search, color: kapkColor),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 10), // Adjust padding if necessary
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: kapkColor, width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            childAspectRatio: 0.79, // Adjust if needed
            crossAxisCount: 2,
            shrinkWrap: true,
            padding: EdgeInsets.all(10), // Add padding around the grid
            children: List.generate(
              _filteredProdukInfo.length,
              (index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        gambar: _filteredProdukInfo[index].gambar,
                        nama: _filteredProdukInfo[index].nama,
                        deskripsi: _filteredProdukInfo[index].deskripsi,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  margin: EdgeInsets.all(10), // Adjust margin to fit design
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 10, // Maintain aspect ratio
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            _filteredProdukInfo[index].gambar,
                            fit: BoxFit.cover, // Ensure proper scaling
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                  child: Icon(Icons.error,
                                      color:
                                          Colors.red)); // Center the error icon
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _filteredProdukInfo[index].nama,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF0E2954),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _filteredProdukInfo[index].harga,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF0E2954),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Info {
  final String gambar;
  final String nama;
  final String deskripsi;
  final String harga;

  Info({
    required this.gambar,
    required this.nama,
    required this.deskripsi,
    required this.harga,
  });
}
