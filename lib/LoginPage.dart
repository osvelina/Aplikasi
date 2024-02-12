
import 'package:apk_barbershop/constant.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                  "Welcome Back",
                  style: textTextStyle.copyWith(fontSize: 30, fontWeight: bold),
                ),
                SizedBox(height: 11),
                Text(
                  "Tugas Akhir Universitas Diponegoro Tahun 2024 harus lulus ga da kata ngga lululs okokokok",
                  style: textTextStyle.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 34),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: textTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: whiteColor,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: textTextStyle.copyWith(fontSize: 12, color: textColor.withOpacity(0.6)),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Password",
                      style: textTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: whiteColor,
                      ),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "password",
                          hintStyle: textTextStyle.copyWith(fontSize: 12, color: textColor.withOpacity(0.6)),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                          suffixIcon: Icon(Icons.visibility_off),
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
                    onPressed: () {},
                    child: Text(
                      "LOGIN",
                      style: WhiteTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
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
