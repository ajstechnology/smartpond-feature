import 'package:flutter/material.dart';
import 'package:smartpond/data/model/response/base/api_response.dart';
import 'package:smartpond/provider/splash_provider.dart';
import 'package:smartpond/view/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

class ApiChecker {
  static void checkApi(BuildContext context, ApiResponse apiResponse) {
    if (apiResponse.error is! String &&
        apiResponse.error.errors[0].message == 'Unauthenticated.') {
      Provider.of<SplashProvider>(context, listen: false).removeSharedData();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_errorMessage, style: TextStyle(color: Colors.white)),
          duration: Duration(milliseconds: 600),
          backgroundColor: Colors.red));
    }
  }
}
