import 'dart:math';

import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';
import 'package:apk_barbershop/api_controller.dart';
import 'package:apk_barbershop/LoginPage.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordVisible = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _genderController = TextEditingController();
  final _addressController = TextEditingController();
  final _apiController = ApiController(); // instantiate ApiController

  final _phoneFocusNode = FocusNode();
  String _phoneHint = 'Phone Number'; // Default hint text
  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(() {
      if (_phoneFocusNode.hasFocus) {
        setState(() {
          _phoneHint = '0800-0000-0000'; // Show formatted hint when focused
        });
      } else {
        setState(() {
          _phoneHint = 'Phone Number'; // Reset hint when unfocused
        });
      }
    });
  }

  void _register() async {
    try {
      print('Register button pressed');
      print('Trying to register');
      var result = await _apiController.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _phoneController.text,
        _birthDateController.text,
        _genderController.text,
        _addressController.text,
      );
      print('Register response: $result');
      // Handle the result as needed
      if (result != null && result['messages'] != null) {
        // Check if 'success' is true
        print('Registration successful, navigating to Login');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false,
        );
      } else {
        print('Registration failed');
      }
    } catch (e) {
      print('Error occurred: $e');
      // Handle the error as needed
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

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
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Mengatur jarak padding
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                size: 24.0), // Menyesuaikan ukuran icon
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
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
                controller: _emailController,
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
                controller: _passwordController,
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
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
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
              SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                focusNode: _phoneFocusNode,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _PhoneNumberFormatter(),
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffE5E5E5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  hintText: _phoneHint,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _birthDateController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffE5E5E5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Birth Date',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffE5E5E5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Gender',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffE5E5E5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Address',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    },
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
                  onPressed: _register,
                  child: Text(
                    "CREATE ACOUNT",
                    style:
                        WhiteTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    // Masukkan karakter format sesuai panjang string
    if (text.length > 0) buffer.write(text.substring(0, min(text.length, 4)));
    if (text.length > 4)
      buffer.write('-${text.substring(4, min(text.length, 8))}');
    if (text.length > 8)
      buffer.write('-${text.substring(8, min(text.length, 12))}');

    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
