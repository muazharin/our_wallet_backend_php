import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Callcenter {
  openWa() async {
    String phone = "+6285157726507";
    String message = "Hallo, OW App! Saya butuh bantuan";
    var whatsappUrl = "https://wa.me/$phone/?text=${Uri.parse(message)}";
    if (Platform.isIOS) {
      whatsappUrl =
          "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}";
    }
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      Fluttertoast.showToast(
        msg: "Tidak ada aplikasi Whatsapp",
      );
    }
  }
}
