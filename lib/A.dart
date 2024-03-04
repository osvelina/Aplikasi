import 'package:flutter/material.dart';

class Percobaan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Breakdown',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your App Title'),
        ),
        body: Center(
          child: Text('Your main content here'),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          child: Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: _buildPriceBreakdown(),
                  ),
                ),
                _buildCheckoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Breakdown',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          _buildPriceRow('Base Price', '\$125.50'),
          _buildPriceRow('Taxes', '\$12.25'),
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
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        'Checkout (\$137.75)',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
