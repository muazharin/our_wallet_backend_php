import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet_mobile/pages/auth/auth_login.dart';
import 'package:our_wallet_mobile/pages/menu/main_menu.dart';
import 'package:our_wallet_mobile/services/service_auth.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/confirm_page.dart';
import 'package:our_wallet_mobile/widgets/input_text.dart';
import 'package:our_wallet_mobile/widgets/primary_button.dart';
import 'package:our_wallet_mobile/widgets/snackbar.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCreatePassword extends StatefulWidget {
  const AuthCreatePassword({
    Key? key,
    required this.data,
    required this.isRecreate,
  }) : super(key: key);
  final dynamic data;
  final bool? isRecreate;
  @override
  _AuthCreatePasswordState createState() => _AuthCreatePasswordState();
}

class _AuthCreatePasswordState extends State<AuthCreatePassword> {
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  final keySend = new GlobalKey<FormState>();
  bool isLoading = false;
  bool isShow = true;
  bool isShowConfirm = true;

  validation() {
    if (password.text == "" || passwordConfirm.text == "") {
      return false;
    } else {
      return true;
    }
  }

  handleCreatePassword() async {
    if (keySend.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      keySend.currentState!.save();
      var body = {'password': password.text};
      AuthServices()
          .authCreatePassword(body, widget.data['phone'])
          .then((value) {
        if (value is String) {
          final snackBar = snackBarAlert('error', value);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var result = jsonDecode(value.body);
          if (result['status']) {
            if (widget.isRecreate!) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ConfirmPage(
                  text: "Password berhasil diubah",
                  textButton: "Masuk Sekarang",
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => AuthLoginPage()),
                        (route) => false);
                  },
                ),
              ));
            } else {
              setLocalStorage();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ConfirmPage(
                  text: result['message'],
                  textButton: "Mulai Sekarang",
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MainMenu()),
                        (route) => false);
                  },
                ),
              ));
            }
          } else {
            final snackBar = snackBarAlert('error', result['message']);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      });
    }
  }

  setLocalStorage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      sp.setInt("id", widget.data['id']);
      sp.setString("username", widget.data['username']);
      sp.setString("email", widget.data['email']);
      sp.setString("phone", widget.data['phone']);
      sp.setString("photo", widget.data['photo']);
      sp.setString("gender", widget.data['gender']);
      sp.setString("tgllahir", widget.data['tgllahir']);
      sp.setString("address", widget.data['address']);
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
            child: Form(
              key: keySend,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(
                    text:
                        widget.isRecreate! ? "Ubah Password" : "Buat Password",
                    size: 24,
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: SvgPicture.asset(
                      "assets/svg/create.svg",
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextInput(
                    hintText: "Masukkan Password",
                    obscureText: isShow,
                    controller: password,
                    onChange: (v) {
                      setState(() {});
                    },
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
                  TextInput(
                    hintText: "Masukkan Konfirmasi Password",
                    obscureText: isShowConfirm,
                    controller: passwordConfirm,
                    onChange: (v) {
                      setState(() {});
                    },
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isShowConfirm = !isShowConfirm;
                        });
                      },
                      child: Icon(
                        isShowConfirm
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: primaryWater,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  ButtonPrimary(
                    title: "Simpan",
                    textSize: 16,
                    bgColor: validation() ? primaryBlood : primaryBloodLight,
                    hvColor: validation() ? primaryBloodLight : Colors.white,
                    onTap: validation()
                        ? () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            if (password.text != passwordConfirm.text) {
                              final snackBar =
                                  snackBarAlert('error', 'Password tidak sama');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              handleCreatePassword();
                            }
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
