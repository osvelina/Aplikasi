import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Nama Anda';
  String phoneNumber = 'Nomor Telepon Anda';
  String dateOfBirth = 'Tanggal Lahir Anda';
  String gender = 'Jenis Kelamin Anda';
  String content = 'Konten Anda';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Halaman Profil'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Implementasi untuk mengubah foto profil
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://www.example.com/path/to/image.jpg', // Ganti dengan URL gambar profil
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildProfileItem('Nama', name, () {
                _editProfileItem('Nama', (newValue) {
                  setState(() {
                    name = newValue;
                  });
                });
              }),
              _buildProfileItem('No Telp', phoneNumber, () {
                _editProfileItem('No Telp', (newValue) {
                  setState(() {
                    phoneNumber = newValue;
                  });
                });
              }),
              _buildProfileItem('Tanggal Lahir', dateOfBirth, () {
                _editProfileItem('Tanggal Lahir', (newValue) {
                  setState(() {
                    dateOfBirth = newValue;
                  });
                });
              }),
              _buildProfileItem('Jenis Kelamin', gender, () {
                _editProfileItem('Jenis Kelamin', (newValue) {
                  setState(() {
                    gender = newValue;
                  });
                });
              }),
              _buildProfileItem('Content', content, () {
                _editProfileItem('Content', (newValue) {
                  setState(() {
                    content = newValue;
                  });
                });
              }),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        // Tambahkan logika untuk tombol Live Chat
                      },
                      child: Text('Live Chat'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        // Tambahkan logika untuk tombol FAQ
                      },
                      child: Text('FAQ'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        // Tambahkan logika untuk tombol LogOut
                      },
                      child: Text('LogOut'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value, Function() onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _editProfileItem(String label, Function(String) onChanged) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Edit $label'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Masukkan $label baru'),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                onChanged(controller.text);
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
