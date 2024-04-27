import 'package:flutter/material.dart';

class Pertanyaan extends StatefulWidget {
  const Pertanyaan({Key? key}) : super(key: key);

  @override
  State<Pertanyaan> createState() => _PertanyaanState();
}

class _PertanyaanState extends State<Pertanyaan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
             shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10), // Atur radius di bagian bawah AppBar
              ),
             ),
            title: Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'Pertanyaan',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                )
              ],
            ),
           
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                  child: Text(
                    'Ada Pertanyaan tentang\nDaeng Barbershop?\nTanyakan kepada kami\ndi bawah ini',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'RadioCanada',
                    ),
                  ),
                ),
                SizedBox(height: 29),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) {
                      // Lakukan sesuatu ketika teks berubah
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari Pertanyaan',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "FAQ",
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                buildListTile('Bagaimana cara mendapatkan voucher ?'),
                Divider(),
                buildListTile('Dimana saja cabang Daeng Barbershop ?'),
                Divider(),
                buildListTile('Gaya rambut yang cocok'),
                Divider(),
                buildListTile('Berdasarkan bentuk wajah'),
                Divider(),
                buildListTile('Berdasarkan tipe rambut'),
                
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: Text(
                        'Masih perlu bantuan ? Hubungi kami di WhatsApp',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton.tonal(
                          onPressed: () {},
                          child: const Text('Kirim Pesan'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListTile(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF15161E),
          fontFamily: 'Outfit',
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: Color(0xFF606A85),
        size: 24,
      ),
      onTap: () {
        // Tambahkan logika yang sesuai ketika teks diklik
        print('$title clicked');
      },
    );
  }
}
