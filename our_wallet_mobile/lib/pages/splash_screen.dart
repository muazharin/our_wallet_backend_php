import 'dart:async';

import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/pages/menu/main_menu.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    cekLogin();
    super.initState();
  }

  cekLogin() async {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      if (sp.getInt('id') != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainMenu(),
        ));
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AuthLoginPage()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/png/wallet_red.png",
              width: 150,
              height: 150,
            ),
            SizedBox(height: 8),
            TextBold(
              text: "Our Wallet",
              size: 24,
              color: primaryBlood,
            ),
          ],
        ),
      ),
    );
  }
}
