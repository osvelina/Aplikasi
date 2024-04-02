import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  const Register({Key?key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'RadioCanada',
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffE5E5E5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Full Name',
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffE5E5E5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffE5E5E5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: _isPasswordVisible ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {},
                  child: Text('Sign In'),
                ),
              ],
            ),
            Container(
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primarybuttonColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      "CREATE ACOUNT",
                      style: WhiteTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
