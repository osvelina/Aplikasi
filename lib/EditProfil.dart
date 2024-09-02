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
            _phoneHint = '080000000000'; // Format hint saat fokus
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

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        _TanggallahirController.text =
            '${selectedDate.toLocal()}'.split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
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
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _TanggallahirController,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Lahir',
                      hintText: 'yyyy-mm-dd',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
              ),
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
          height: 200,
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
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
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
    if (digits.length <= 4) return digits;
    if (digits.length <= 8)
      return '${digits.substring(0, 4)}-${digits.substring(4)}';
    return '${digits.substring(0, 4)}-${digits.substring(4, 8)}-${digits.substring(6)}';
  }
}
