import 'dart:async';
import 'dart:io';

import 'package:our_wallet_mobile/constant.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future authCheckPhoneNumber(body) async {
    Uri url = Uri.parse("$baseurl/auth/auth_check_phone_number");
    try {
      return await http.post(url, body: body).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      print(e);
      return 'Error: ' + e.toString();
    }
  }

  Future authLogin(body) async {
    Uri url = Uri.parse("$baseurl/auth/auth_login");
    try {
      return await http.post(url, body: body).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      print(e);
      return 'Error: ' + e.toString();
    }
  }

  Future authRegister(body) async {
    Uri url = Uri.parse("$baseurl/auth/auth_register");
    try {
      return await http.post(url, body: body).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      print(e);
      return 'Error: ' + e.toString();
    }
  }

  Future authCreatePassword(body, phone) async {
    Uri url = Uri.parse("$baseurl/auth/auth_create_password?phone=$phone");
    try {
      return await http.post(url, body: body).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      print(e);
      return 'Error: ' + e.toString();
    }
  }
}
