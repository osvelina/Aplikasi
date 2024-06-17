import 'package:apk_barbershop/Daerah.dart';
import 'package:apk_barbershop/Register.dart';
import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';
import 'package:apk_barbershop/api_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiController _apiController = ApiController();
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome\nDaeng Barbershop",
                style: textTextStyle.copyWith(fontSize: 30, fontWeight: bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 11),
              SizedBox(height: 34),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style:
                        textTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                    ),
                    child: TextField(
                      controller: _emailController,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Password",
                    style:
                        textTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        suffix: InkWell(
                          onTap: _toggleVisibility,
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      print('Teks Forget Password diklik!');
                      // Implementasi untuk menangani aksi lupa password
                    },
                    child: Text(
                      'Forget Password ?',
                      style: textTextStyle.copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primarybuttonColor,
                  ),
                  onPressed: () async {
                    print('Login button pressed');
                    try {
                      print('Trying to login');
                      var response = await _apiController.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                      print('Login response: $response');
                      // Jika login berhasil, navigasi ke Daerah
                      if (response.containsKey('access_token')) {
                        print('Login successful, navigating to Daerah');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Daerah()),
                        );
                      } else {
                        print('Login failed');
                      }
                    } catch (e) {
                      print('Error occurred: $e');
                      // Handle error here
                    }
                  },
                  child: Text(
                    "LOGIN",
                    style:
                        WhiteTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Text(
                  'Belum punya akun? Daftar sekarang!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
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
