import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

import 'auth/auth_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AuthLoginPage()),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/wallet.svg",
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            TextBold(
              text: "Our Wallet",
              size: 24,
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
