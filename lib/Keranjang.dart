import 'package:apk_barbershop/Pembayaran.dart';
import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Map<String, bool> productCheckboxes = {
    'assets/images/1.jpg': false,
    'assets/images/5.jpg': false,
    'assets/images/6.jpg': false,
    'assets/images/2.jpg': false,
    'assets/images/3.jpg': false,
    'assets/images/4.jpg': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),

      body: SingleChildScrollView(
        child: Column(
          children: productCheckboxes.keys.map((String imageUrl) {
            return _buildProductItem(
              imageUrl: imageUrl,
              productName: 'Controller Basic',
              price: '\$125.50',
              quantity: '1',
              isChecked: productCheckboxes[imageUrl] ?? false,
              onCheckboxChanged: (bool? value) {
                setState(() {
                  productCheckboxes[imageUrl] = value ?? false;
                });
              },
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          color: kapkColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 16), // Spasi di sisi kiri
            Expanded(
              child: _buildCheckoutButton(),
            ),
            SizedBox(width: 16), // Spasi di sisi kanan
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      persistentFooterButtons: [
        _buildPriceBreakdown(),
      ],
    );
  }

  Widget _buildProductItem({
    required String imageUrl,
    required String productName,
    required String price,
    required String quantity,
    required bool isChecked,
    required Function(bool?) onCheckboxChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8), // Atur padding kiri dan atas
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onCheckboxChanged,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0), // Atur padding kiri gambar
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text('Price: $price'),
                  Text('Quantity: $quantity'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rincian Pembayaran',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          _buildPriceRow('Harga', '\$125.50'),
          _buildPriceRow('Pengiriman', '\$12.25'),
          _buildPriceRow('Total', '\$137.75'),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(price),
      ],
    );
  }

  Widget _buildCheckoutButton() {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Bayar()),
    );
    },
    style: ElevatedButton.styleFrom(
      // ignore: deprecated_member_use
      primary: kapkColor, // Warna latar belakang tombol
      // ignore: deprecated_member_use
      onPrimary: Colors.white, // Warna teks
      elevation: 0, // Set elevasi menjadi 0 untuk menghilangkan bayangan
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Atur radius sudut
      ),
    ),
    child: Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(
        'Checkout (\$137.75)',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ),
  );
}

}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.grey[200],
    elevation: 5,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.black,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(
      'Keranjang',
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true, // Menyatukan judul AppBar ke tengah
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      ),
    ),
  );
}
