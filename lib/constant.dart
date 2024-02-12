import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Color whiteColor = Color(0Xffffffff);
Color textColor = Color(0xff0D0140);
Color secondaryTextColor = Color(0xff524B6B);
Color buttonColor = Color(0xffE6E1FF);
Color primarybuttonColor =  Color(0xff130160);
Color tncbuttonColor =  Color(0xff130160);


TextStyle WhiteTextStyle = GoogleFonts.dmSans(
  color: whiteColor,
);

TextStyle textTextStyle = GoogleFonts.dmSans(
  color: textColor,
);

TextStyle secondaryTextStyle = GoogleFonts.dmSans(
  color: secondaryTextColor,
);

TextStyle tncTextStyle = GoogleFonts.dmSans(
  color: tncbuttonColor,
);


FontWeight bold = FontWeight.bold;

class AppColor {
  static Color primary = Color(0xFF094542);
  static Color primarySoft = Color(0xFF0B5551);
  static Color primaryExtraSoft = Color(0xFFEEF4F4);
  static Color secondary = Color(0xFFEDE5CC);
  static Color whiteSoft = Color(0xFFF8F8F8);
  static LinearGradient bottomShadow = LinearGradient(colors: [Color(0xFF107873).withOpacity(0.2), Color(0xFF107873).withOpacity(0)], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  static LinearGradient linearBlackBottom = LinearGradient(colors: [Colors.black.withOpacity(0.45), Colors.black.withOpacity(0)], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  static LinearGradient linearBlackTop = LinearGradient(colors: [Colors.black.withOpacity(0.5), Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

const kDefaultPaddin = 20.0;
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);
const kMainColor = Color(0xFFFFB9C4);
const kMainDarkColor = Color(0xFFC7051A);
