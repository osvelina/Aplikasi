import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'api_controller.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _NoTLPController = TextEditingController();
  TextEditingController _TanggallahirController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();

  final ApiController _apiController = ApiController();

  final _phoneFocusNode = FocusNode();
  String _phoneHint = 'Phone Number'; // Default hint text

  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(() {
      if (_phoneFocusNode.hasFocus) {
        if (_phoneHint != '0800-0000-0000') {
          setState(() {
            _phoneHint = '0800-0000-0000'; // Format hint saat fokus
          });
        }
      } else {
        if (_phoneHint != 'Phone Number') {
          setState(() {
            _phoneHint = 'Phone Number'; // Reset hint saat tidak fokus
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _NoTLPController.dispose();
    _TanggallahirController.dispose();
    _alamatController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Profile updated successfully'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Navigate back to profile page
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _TopPortion(),
        ),
      ),
      body: SingleChildScrollView(
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
                focusNode: _phoneFocusNode,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _PhoneNumberFormatter(), // Gunakan formatter yang sama
                ],
                decoration: InputDecoration(
                  labelText: 'No Telepon',
                  hintText: _phoneHint,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _TanggallahirController,
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
              ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _emailController,
              //   decoration: InputDecoration(labelText: 'Email'),
              // ),
              SizedBox(height: 32.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0E2954),
                ),
                onPressed: () async {
                  try {
                    await _apiController.updateProfile(
                      name: _nameController.text,
                      noTelp: _NoTLPController.text,
                      tanggalLahir:
                          DateTime.parse(_TanggallahirController.text),
                      alamat: _alamatController.text,
                      // email: _emailController.text,
                    );
                    // Jika berhasil
                    _showSuccessDialog();
                  } catch (e) {
                    // Jika gagal
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update profile')),
                    );
                  }
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

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final formatted = _formatPhoneNumber(digitsOnly);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatPhoneNumber(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6)
      return '${digits.substring(0, 3)}-${digits.substring(3)}';
    return '${digits.substring(0, 3)}-${digits.substring(3, 6)}-${digits.substring(6)}';
  }
}
