import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet_mobile/pages/auth/auth_create_password.dart';
import 'package:our_wallet_mobile/services/service_auth.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/utils/form_validation.dart';
import 'package:our_wallet_mobile/widgets/input_text.dart';
import 'package:our_wallet_mobile/widgets/loading_button.dart';
import 'package:our_wallet_mobile/widgets/primary_button.dart';
import 'package:our_wallet_mobile/widgets/snackbar.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class AuthRegisterForm extends StatefulWidget {
  const AuthRegisterForm({Key? key, @required this.phonenumber})
      : super(key: key);
  final String? phonenumber;
  @override
  _AuthRegisterFormState createState() => _AuthRegisterFormState();
}

class _AuthRegisterFormState extends State<AuthRegisterForm> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController tgllahir = TextEditingController();
  TextEditingController address = TextEditingController();
  final keySend = new GlobalKey<FormState>();
  Object? gender;
  bool isLoading = false;
  @override
  void initState() {
    gender = "Pria";
    phonenumber.text = widget.phonenumber!;
    super.initState();
  }

  validation() {
    if (username.text == "" ||
        phonenumber.text == "" ||
        email.text == "" ||
        tgllahir.text == "" ||
        address.text == "") {
      return false;
    } else {
      return true;
    }
  }

  handleRegisterForm() async {
    if (keySend.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      keySend.currentState!.save();
      var body = {
        'username': username.text,
        'email': email.text,
        'phone': phonenumber.text,
        'gender': gender.toString(),
        'tgllahir': tgllahir.text,
        'address': address.text,
      };
      AuthServices().authRegister(body).then((value) {
        setState(() {
          isLoading = false;
        });
        if (value is String) {
          final snackBar = snackBarAlert('error', value);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var result = jsonDecode(value.body);
          if (result['status']) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AuthCreatePassword(
                data: result['data'],
                isRecreate: false,
              ),
            ));
          } else {
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
                  text: "Form Pendaftaran",
                  size: 24,
                ),
                SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: keySend,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Center(
                            child: SvgPicture.asset(
                              "assets/svg/form.svg",
                              height: 150,
                              width: 150,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextInput(
                            hintText: "Masukkan Username",
                            controller: username,
                            validator: validationString,
                            onChange: (v) {
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 8),
                          TextInput(
                            hintText: "Masukkan Email",
                            controller: email,
                            validator: validationEmail,
                            onChange: (v) {
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 8),
                          TextInput(
                            hintText: "Masukkan Nomor Telepon",
                            keyboardType: TextInputType.phone,
                            controller: phonenumber,
                            validator: validationPhoneNumber,
                            onChange: (v) {
                              setState(() {});
                            },
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              final snackBar = snackBarAlert(
                                  'info', 'Nomor telpon terisi otomatis');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: "Pria",
                                groupValue: gender,
                                onChanged: (v) {
                                  setState(() {
                                    gender = v;
                                    print(gender);
                                  });
                                },
                              ),
                              TextRegular(
                                text: "Pria",
                                color: grayscaleCharcoalLightest,
                                size: 14.0,
                              ),
                              Spacer(),
                              Radio(
                                value: "Wanita",
                                groupValue: gender,
                                onChanged: (v) {
                                  setState(() {
                                    gender = v;
                                    print(gender);
                                  });
                                },
                              ),
                              TextRegular(
                                text: "Wanita",
                                color: grayscaleCharcoalLightest,
                                size: 14.0,
                              ),
                              Spacer(),
                            ],
                          ),
                          TextInput(
                            hintText: "Pilih Tanggal Lahir",
                            controller: tgllahir,
                            validator: validationString,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down,
                              color: primaryWater,
                            ),
                            onChange: (v) {
                              setState(() {});
                            },
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              DatePicker.showDatePicker(
                                context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true,
                                minTime: DateTime(1900, 1, 1),
                                maxTime: DateTime.now(),
                                onConfirm: (date) {
                                  setState(() {
                                    tgllahir.text =
                                        '${date.year}-${date.month}-${date.day}';
                                  });
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.id,
                              );
                            },
                          ),
                          SizedBox(height: 8),
                          TextInput(
                            hintText: "Masukkan Alamat",
                            maxLines: 4,
                            controller: address,
                            validator: validationString,
                            onChange: (v) {
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 8),
                          TextRegular(
                            text:
                                "Pastikan data diri Anda telah diisi dengan baik dan benar sesuai dengan syarat dan ketentuan.",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                isLoading
                    ? LoadingButton()
                    : ButtonPrimary(
                        title: "Daftar",
                        textSize: 16,
                        bgColor:
                            validation() ? primaryBlood : primaryBloodLight,
                        hvColor:
                            validation() ? primaryBloodLight : Colors.white,
                        onTap: validation()
                            ? () {
                                handleRegisterForm();
                              }
                            : null,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
