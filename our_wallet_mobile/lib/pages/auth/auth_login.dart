import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet_mobile/pages/auth/auth_forgot_password.dart';
import 'package:our_wallet_mobile/pages/auth/auth_register.dart';
import 'package:our_wallet_mobile/pages/menu/main_menu.dart';
import 'package:our_wallet_mobile/services/service_auth.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/utils/form_validation.dart';
import 'package:our_wallet_mobile/widgets/input_text.dart';
import 'package:our_wallet_mobile/widgets/loading_button.dart';
import 'package:our_wallet_mobile/widgets/primary_button.dart';
import 'package:our_wallet_mobile/widgets/snackbar.dart';
import 'package:our_wallet_mobile/widgets/text_button.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({Key? key}) : super(key: key);

  @override
  _AuthLoginPageState createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final keySend = new GlobalKey<FormState>();
  bool isLoading = false;
  bool isShow = true;

  validation() {
    if (username.text == "" || password.text == "") {
      return false;
    } else {
      return true;
    }
  }

  handleLogin() async {
    if (keySend.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      keySend.currentState!.save();
      var body = {'username': username.text, 'password': password.text};
      AuthServices().authLogin(body).then((value) {
        setState(() {
          isLoading = false;
        });
        if (value is String) {
          final snackBar = snackBarAlert('error', value);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var result = jsonDecode(value.body);
          if (result['status']) {
            setLocalStorage(result['data']);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainMenu(),
            ));
          } else {
            final snackBar = snackBarAlert('error', result['message']);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      });
    }
  }

  setLocalStorage(data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      sp.setInt("id", int.parse(data['id']));
      sp.setString("username", data['username']);
      sp.setString("email", data['email']);
      sp.setString("phone", data['phone']);
      sp.setString("photo", data['photo']);
      sp.setString("gender", data['gender']);
      sp.setString("tgllahir", data['tgllahir']);
      sp.setString("address", data['address']);
    });
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBold(
                  text: "Masuk",
                  size: 24,
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: keySend,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/login.svg",
                              width: 150,
                              height: 150,
                            ),
                            SizedBox(height: 16),
                            TextInput(
                              hintText:
                                  "Masukkan Username, Email atau No. Telp",
                              controller: username,
                              onChange: (v) {
                                setState(() {});
                              },
                              validator: validationString,
                            ),
                            SizedBox(height: 8),
                            TextInput(
                              hintText: "Masukkan Password",
                              obscureText: isShow,
                              controller: password,
                              onChange: (v) {
                                setState(() {});
                              },
                              validator: validationPassword,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isShow = !isShow;
                                  });
                                },
                                child: Icon(
                                  isShow
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: primaryWater,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Spacer(),
                                ButtonText(
                                  text: "Lupa Password?",
                                  textColor: Colors.black54,
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          AuthForgotPassword(),
                                    ));
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            isLoading
                                ? LoadingButton()
                                : ButtonPrimary(
                                    title: "Masuk",
                                    textSize: 16,
                                    bgColor: validation()
                                        ? primaryBlood
                                        : primaryBloodLight,
                                    hvColor: validation()
                                        ? primaryBloodLight
                                        : Colors.white,
                                    onTap: validation()
                                        ? () {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            handleLogin();
                                          }
                                        : null,
                                  ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextRegular(text: "Belum memiliki akun? "),
                    ButtonText(
                      text: "Daftar",
                      textColor: primaryBlood,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AuthRegisterPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
