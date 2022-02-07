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
      print(e);
      return 'Error: ' + e.toString();
    }
  }

  Future getMemberWallet(params) async {
    Uri url = Uri.parse("$baseurl/wallet/get_member_of_wallet/${params['id']}");
    print(url);
    try {
      return await http.get(url).timeout(Duration(seconds: 10));
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
