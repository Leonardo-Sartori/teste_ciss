import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 5));
    
    if(result.isEmpty || result[0].rawAddress.isEmpty){
      return false;
    }

    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

Future<bool> isConnectedWifi() async {
  try {
    late ConnectivityResult result;
    result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi) {
      return true;
    }
     else {
      return false;
     }
  } on SocketException catch (_) {
    return false;
  }
}

Future<bool> isConnectedMobile() async {
  try {
    late ConnectivityResult result;
    result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) {
      return true;
    }
     else {
      return false;
     }
  } on SocketException catch (_) {
    return false;
  }
}