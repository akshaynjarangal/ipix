
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
/*
 ------------------------- SIZEDBOX METHOD -----------------------
*/
setWidth({required double width}) {
  return SizedBox(
    width: width,
  );
}

setHeight({required double height}) {
  return SizedBox(height: height);
}

class AppColors{
  static Color amber =  Colors.amber.shade700;
  static Color black =  Colors.black87;
  static Color white =  Colors.white;
  static Color green = Colors.green;
}

class AppUrls{
    /*
 ------------------------- API URLs -----------------------
*/
  static String host = 'run.mocky.io'; 
  static String basePath = 'v3';
  static String restaurantsEndPoint = '$basePath/b91498e7-c7fd-48bc-b16a-5cb970a3af8a';
  static String gmap = 'www.google.com';
  static String gmapEndPoint ='/maps/search/';
}

final client = http.Client();



enum MainFailures{
  serverFailure,
  internetFailure,
  noInternetFailure,
  formatExceptionFailure,
  noContentFailure,
  unAuthorized,
  notAcceptable,
  unprocessable
}

class EmailTextInputFormatter extends TextInputFormatter {
  final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow the user to delete characters
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Validate the new value against the email regex
    if (_emailRegex.hasMatch(newValue.text)) {
      return newValue; // Valid email, allow the update
    }

    // Invalid email, revert to the old value
    return oldValue;
  }
}