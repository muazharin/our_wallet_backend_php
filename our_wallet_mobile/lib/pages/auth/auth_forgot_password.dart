import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet_mobile/pages/auth/auth_otp.dart';
import 'package:our_wallet_mobile/services/service_auth.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/utils/firebase_otp.dart';
import 'package:our_wallet_mobile/utils/form_validation.dart';
import 'package:our_wallet_mobile/widgets/input_text.dart';
import 'package:our_wallet_mobile/widgets/loading_button.dart';
import 'package:our_wallet_mobile/widgets/primary_button.dart';
import 'package:our_wallet_mobile/widgets/snackbar.dart';
import 'package:our_wallet_mobile/widgets/text_button.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class AuthForgotPassword extends StatefulWidget {
  const AuthForgotPassword({Key? key}) : super(key: key);

  @override
  _AuthForgotPasswordState createState() => _AuthForgotPasswordState();
}

class _AuthForgotPasswordState extends State<AuthForgotPassword> {
  TextEditingController phonenumber = TextEditingController();
  final keySend = new GlobalKey<FormState>();
  bool isLoading = false;
  validation() {
    if (phonenumber.text == "") {
      return false;
    } else {
      return true;
    }
  }

  handlePhoneNumber() async {
    if (keySend.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      keySend.currentState!.save();
      var body = {'phonenumber': phonenumber.text};
      AuthServices().authCheckPhoneNumber(body).then((value) {
        if (value is String) {
          setState(() {
            isLoading = false;
          });
          final snackBar = snackBarAlert('error', value);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var result = jsonDecode(value.body);
          if (result['status']) {
            sendOtp(
              phonenumber.text,
              "forgotpassword",
              false,
              context,
              () {
                setState(() {
                  isLoading = false;
                });
              },
              () {
                setState(() {
                  isLoading = false;
                });
              },
            );
          } else {
            setState(() {
              isLoading = false;
            });
            final snackBar = snackBarAlert('error', result['message']);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      });
    }
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
                  text: "Lupa Password",
                  size: 24,
                ),
                Expanded(
                  child: Form(
                    key: keySend,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/forgot.svg",
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(height: 16),
                        TextInput(
                          hintText: "Masukkan Nomor Telepon",
                          keyboardType: TextInputType.phone,
                          controller: phonenumber,
                          validator: validationPhoneNumber,
                          onChange: (v) {
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 16),
                        isLoading
                            ? LoadingButton()
                            : ButtonPrimary(
                                title: "Daftar",
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
                                        handlePhoneNumber();
                                      }
                                    : null,
                              ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextRegular(text: "Tekan tombol kembali untuk "),
                    ButtonText(
                      text: "Masuk",
                      textColor: primaryBlood,
                      onTap: () => Navigator.pop(context),
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
