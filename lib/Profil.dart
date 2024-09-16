import 'dart:ui';

import 'package:apk_barbershop/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'EditProfil.dart';
import 'Pertanyaan.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final userInfo = snapshot.data!;
          return Scaffold(
            body: CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 110,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Stack(
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xFF0E2954),
                              Color(0xFF0E2954),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: Stack(
                            fit: StackFit.expand,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 700,
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              userInfo['userName'] ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfilePage()),
                                );
                              },
                              child: Text('Edit Profile'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            _buildInfoCard(context,
                                title: 'Name',
                                value: userInfo['userName'] ?? ''),
                            _buildInfoCard(context,
                                title: 'Phone',
                                value: userInfo['phoneNumber'] ?? ''),
                            _buildInfoCard(context,
                                title: 'Date of Birth',
                                value: userInfo['birthDate'] ?? ''),
                            _buildInfoCard(context,
                                title: 'Gender',
                                value: userInfo['gender'] ?? ''),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  'Content',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CustomClickableText(
                                  text: 'Live Chat',
                                  icon: Icons.chat,
                                  onTap: () {
                                    WhatsAppButton()._launchWhatsApp();
                                  },
                                ),
                                CustomClickableText(
                                  text: 'FAQ',
                                  icon: Icons.question_answer,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Pertanyaan()),
                                    );
                                  },
                                ),
                                CustomClickableText(
                                  text: 'Log Out',
                                  icon: Icons.logout,
                                  onTap: () {
                                    _showLogoutConfirmation(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<Map<String, String>> _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userName': prefs.getString('userName') ?? '',
      'phoneNumber': prefs.getString('phoneNumber') ?? '',
      'birthDate': prefs.getString('birthDate') ?? '',
      'gender': prefs.getString('gender') ?? '',
    };
  }

  Widget _buildInfoCard(BuildContext context,
      {required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      child: InkWell(
        onTap: () {
          // Action when tapped
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF0E2954),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Background blur effect
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 5.0, sigmaY: 5.0), // Adjust blur intensity
                child: Container(
                  color:
                      Colors.black.withOpacity(0.5), // Semi-transparent color
                ),
              ),
            ),
            // The AlertDialog
            Center(
              child: AlertDialog(
                backgroundColor: Colors.white, // Background color of the dialog
                title: Text(
                  'Konfirmasi Logout',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Customize title color
                  ),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        'Apakah Anda yakin ingin logout?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87, // Customize content color
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Batal',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Customize button text color
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Customize button text color
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Colors.red, // Background color of the button
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _logout(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('id_user');
    await prefs.remove('id_lokasi');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }
}

class CustomClickableText extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const CustomClickableText({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class WhatsAppButton extends StatelessWidget {
  final String phoneNumber =
      '6281288000901'; // Ganti dengan nomor telepon WhatsApp
  final String message = 'Hallo Admin !'; // Ganti dengan pesan yang diinginkan

  void _launchWhatsApp() async {
    final url = 'https://wa.me/$phoneNumber?text=$message';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _launchWhatsApp,
      child: Text('Chat dengan Kami di WhatsApp'),
    );
  }
}
