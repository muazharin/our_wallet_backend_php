import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet_mobile/pages/auth/auth_register.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/input_text.dart';
import 'package:our_wallet_mobile/widgets/primary_button.dart';
import 'package:our_wallet_mobile/widgets/text_button.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({Key? key}) : super(key: key);

  @override
  _AuthLoginPageState createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBold(
                  text: "Login",
                  size: 24,
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/login.svg",
                            width: 150,
                            height: 150,
                          ),
                          SizedBox(height: 16),
                          TextInput(hintText: "Masukkan Username"),
                          SizedBox(height: 8),
                          TextInput(hintText: "Masukkan Password"),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Spacer(),
                              ButtonText(
                                text: "Lupa Password?",
                                textColor: Colors.black54,
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          ButtonPrimary(
                            title: "Masuk",
                            textSize: 16,
                          ),
                          SizedBox(height: 16),
                          ButtonText(
                            text: "Daftar",
                            textColor: primaryColor,
                            textSize: 16,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AuthRegisterPage(),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
