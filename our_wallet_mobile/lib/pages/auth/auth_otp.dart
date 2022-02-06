import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet_mobile/pages/auth/auth_create_password.dart';
import 'package:our_wallet_mobile/pages/auth/auth_register_form.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/utils/firebase_otp.dart';
import 'package:our_wallet_mobile/widgets/snackbar.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AuthOTP extends StatefulWidget {
  const AuthOTP({
    Key? key,
    required this.verificationId,
    required this.phonenumber,
    required this.option,
  }) : super(key: key);
  final String? phonenumber;
  final String? verificationId;
  final String? option;
  @override
  _AuthOTPState createState() => _AuthOTPState();
}

class _AuthOTPState extends State<AuthOTP> {
  Duration interval = const Duration(seconds: 1);
  int timerMaxSeconds = 90;
  int currentSeconds = 0;
  Timer? timer;
  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
  bool isFinish = false;
  bool isLoading = false;

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  startTimeout() {
    var duration = interval;
    timer = Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          isFinish = true;
          timer.cancel();
        }
      });
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
                  text: "OTP",
                  size: 24,
                ),
                SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/phone.svg",
                        height: 150,
                        width: 150,
                      ),
                      SizedBox(height: 16),
                      TextRegular(
                        text:
                            "Kode telah dikirimkan ke nomor ${widget.phonenumber}",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        onChanged: (v) {},
                        keyboardType: TextInputType.number,
                        animationDuration: Duration(milliseconds: 300),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 45,
                          fieldWidth: 45,
                          activeColor: primaryWater,
                          inactiveColor: grayscaleStone,
                        ),
                        pastedTextStyle: TextStyle(
                          color: primaryWater,
                          fontWeight: FontWeight.bold,
                        ),
                        onCompleted: (v) {
                          verifyPin(v, widget.verificationId!).then((value) {
                            print(value);
                            if (value['status']) {
                              if (widget.option == "register") {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AuthRegisterForm(
                                    phonenumber: widget.phonenumber,
                                  ),
                                ));
                              } else {
                                var data = {"phone": widget.phonenumber};
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AuthCreatePassword(
                                    data: data,
																		isRecreate: true,
                                  ),
                                ));
                              }
                            } else {
                              final snackBar =
                                  snackBarAlert('error', value['message']);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      Center(child: TextBold(text: "$timerText", size: 14)),
                      SizedBox(height: 16.0),
                      Center(
                        child: isLoading
                            ? CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation(primaryBlood),
                              )
                            : InkWell(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  if (isFinish) {
                                    setState(() {
                                      isLoading = false;
                                      isFinish = false;
                                    });
                                    sendOtp(
                                      widget.phonenumber!,
                                      widget.option!,
                                      true,
                                      context,
                                      () {
                                        setState(() {
                                          isLoading = false;
                                          isFinish = true;
                                        });
                                      },
                                      () {
                                        setState(() {
                                          isLoading = false;
                                          isFinish = true;
                                        });
                                      },
                                    );
                                  }
                                },
                                child: TextBold(
                                  text: "Kirim Ulang OTP",
                                  color:
                                      isFinish ? primaryBlood : grayscaleStone,
                                  size: 14,
                                ),
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
