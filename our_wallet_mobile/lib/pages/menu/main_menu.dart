import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/pages/auth/auth_login.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/primary_button.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  keluar() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => AuthLoginPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextRegular(text: "Main Menu"),
                SizedBox(height: 24),
                ButtonPrimary(
                  title: "Keluar",
                  textSize: 16,
                  bgColor: primaryBlood,
                  hvColor: primaryBloodLight,
                  onTap: () {
                    keluar();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
