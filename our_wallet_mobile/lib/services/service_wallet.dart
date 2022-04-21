import 'dart:async';
import 'dart:io';

import 'package:our_wallet_mobile/constant.dart';
import 'package:http/http.dart' as http;

class WalletServices {
  Future getOurWallet(params) async {
    Uri url =
        Uri.parse("$baseurl/wallet/get_wallet?userId=${params['userId']}");
    try {
      return await http.get(url).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future getMemberWallet(params) async {
    Uri url = Uri.parse("$baseurl/wallet/get_member_of_wallet/${params['id']}");
    try {
      return await http.get(url).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future getTransactionWallet(params) async {
    Uri url = Uri.parse(
        "$baseurl/transaction/list_transaction?walletId=${params['walletId']}&userId=${params['userId']}&page=${params['page']}");
    try {
      return await http.get(url).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future createWallet(body) async {
    Uri url = Uri.parse("$baseurl/wallet/create_wallet");
    try {
      return await http.post(url, body: body).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future updateWallet(body, params) async {
    Uri url = Uri.parse(
        "$baseurl/wallet/update_wallet?walletId=${params['walletId']}");
    try {
      return await http.post(url, body: body).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future getUserToWallet(params) async {
    Uri url = Uri.parse(
        "$baseurl/wallet/get_user_to_wallet?owWalletId=${params['owWalletId']}&keyword=${params['keyword']}");
    try {
      return await http.get(url).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }

  Future addMemberWallet(body, params) async {
    Uri url = Uri.parse(
        "$baseurl/wallet/add_member_wallet?owWalletId=${params['owWalletId']}");
    try {
      return await http.post(url, body: body).timeout(Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return 'Request Timeout';
    } on SocketException catch (_) {
      return 'No Connection Internet';
    } catch (e) {
      return 'Error: ' + e.toString();
    }
  }
}
