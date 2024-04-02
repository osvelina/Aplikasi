import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _NoTLPController = TextEditingController();
  TextEditingController _TanggallahirController = TextEditingController();
  TextEditingController _JeniskelaminController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: AppBar(
          flexibleSpace: _TopPortion(),
        ),
      ),
      body: SingleChildScrollView( // Tambahkan SingleChildScrollView
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _NoTLPController,
                decoration: InputDecoration(labelText: 'No Telepon'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _TanggallahirController,
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _JeniskelaminController,
                decoration: InputDecoration(labelText: 'Jenis Kelamin'),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0E2954),
                    ),
                onPressed: () {
                  // Implement save logic here
                  // You can access the entered data via _nameController.text, _emailController.text, _phoneNumberController.text
                },
                child: Text(
                'UBAH',
                style: TextStyle(
                  fontFamily: 'RadioCanada',
                  color: Colors.white,
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

class _TopPortion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
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
            width: 140,
            height: 140,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipOval(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
