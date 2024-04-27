import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _loadData(context); // Pass context to _loadData method
  }

  Future<void> _loadData(BuildContext context) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      // Navigate to the next screen after data loaded
      Navigator.pushReplacementNamed(context, '/Booking');
    } catch (e) {
      // Handle error if any
      EasyLoading.showError('Try Again'); // Display error message
    } finally {
      EasyLoading.dismiss(); // Close loading indicator after process finishes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E2954),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 10,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please Wait\nProcessing...', // Display processing message
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'RadioCanada',
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
