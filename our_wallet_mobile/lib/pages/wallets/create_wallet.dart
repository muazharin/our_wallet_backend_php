import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet_mobile/models/model_wallet.dart';
import 'package:our_wallet_mobile/pages/menu/main_menu.dart';
import 'package:our_wallet_mobile/services/service_wallet.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/utils/form_validation.dart';
import 'package:our_wallet_mobile/widgets/input_text.dart';
import 'package:our_wallet_mobile/widgets/loading_button.dart';
import 'package:our_wallet_mobile/widgets/primary_button.dart';
import 'package:our_wallet_mobile/widgets/radio_button.dart';
import 'package:our_wallet_mobile/widgets/snackbar.dart';
import 'package:our_wallet_mobile/widgets/text_button.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({Key? key, this.walletModel}) : super(key: key);
  final WalletModel? walletModel;
  @override
  _CreateWalletState createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  TextEditingController walletname = TextEditingController();
  final keySend = new GlobalKey<FormState>();
  bool isLoading = false;
  bool isUpdate = false;
  Object? color;

  validation() {
    if (walletname.text == "" || color == null) {
      return false;
    } else {
      return true;
    }
  }

  handleAddWallet() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (keySend.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      keySend.currentState!.save();
      var body = {
        "userId": sp.getInt("id").toString(),
        "walletName": walletname.text,
        "walletColor": color.toString(),
      };
      WalletServices().createWallet(body).then((value) {
        setState(() {
          isLoading = false;
        });
        if (value is String) {
          final snackBar = snackBarAlert('error', value);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var result = jsonDecode(value.body);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainMenu()),
              (route) => false);
          final snackBar = snackBarAlert('success', result['message']);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } else {
      final snackBar =
          snackBarAlert('error', "Lengkapi field dengan baik dan benar!");
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  handleUpdateWallet() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (keySend.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      keySend.currentState!.save();
      var body = {
        "userId": sp.getInt("id").toString(),
        "walletName": walletname.text,
        "walletColor": color.toString(),
      };
      var params = {
        "walletId": widget.walletModel!.walletId,
      };
      WalletServices().updateWallet(body, params).then((value) {
        setState(() {
          isLoading = false;
        });
        if (value is String) {
          final snackBar = snackBarAlert('error', value);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var result = jsonDecode(value.body);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainMenu()),
              (route) => false);
          final snackBar = snackBarAlert('success', result['message']);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } else {
      final snackBar =
          snackBarAlert('error', "Lengkapi field dengan baik dan benar!");
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    setInit();
    super.initState();
  }

  setInit() {
    if (widget.walletModel != null) {
      setState(() {
        walletname.text = widget.walletModel!.walletName!;
        color = widget.walletModel!.walletColor!;
        isUpdate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextBold(
                  text: isUpdate ? "Update Dompet" : "Buat Dompet",
                  size: 24,
                ),
              ),
              SizedBox(height: 24),
              Expanded(
                child: Form(
                  key: keySend,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                "assets/svg/wallet.svg",
                                height: 150,
                                width: 150,
                              ),
                            ),
                            SizedBox(height: 16),
                            TextInput(
                              hintText: "Masukkan Nama Dompet",
                              controller: walletname,
                              validator: validationString,
                              onChange: (v) => setState(() {}),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: s.width / 2,
                            child: RadioButton(
                              groupValue: color,
                              toggle: false,
                              value: "red",
                              text: "Merah",
                              onChanged: (v) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  color = v;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: s.width / 2,
                            child: RadioButton(
                              groupValue: color,
                              toggle: false,
                              value: "blue",
                              text: "Biru",
                              onChanged: (v) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  color = v;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: s.width / 2,
                            child: RadioButton(
                              groupValue: color,
                              toggle: false,
                              value: "black",
                              text: "Hitam",
                              onChanged: (v) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  color = v;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: s.width / 2,
                            child: RadioButton(
                              groupValue: color,
                              toggle: false,
                              value: "grey",
                              text: "Abu-abu",
                              onChanged: (v) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  color = v;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: s.width / 2,
                            child: RadioButton(
                              groupValue: color,
                              toggle: false,
                              value: "yellow",
                              text: "Kuning",
                              onChanged: (v) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  color = v;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: s.width / 2,
                            child: RadioButton(
                              groupValue: color,
                              toggle: false,
                              value: "green",
                              text: "Hijau",
                              onChanged: (v) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  color = v;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: s.width / 2,
                            child: RadioButton(
                              groupValue: color,
                              toggle: false,
                              value: "purple",
                              text: "Ungu",
                              onChanged: (v) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  color = v;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: isLoading
                    ? LoadingButton()
                    : ButtonPrimary(
                        title: "Simpan",
                        textSize: 16,
                        bgColor:
                            validation() ? primaryBlood : primaryBloodLight,
                        hvColor:
                            validation() ? primaryBloodLight : Colors.white,
                        onTap: validation()
                            ? () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                if (isUpdate) {
                                  handleUpdateWallet();
                                } else {
                                  handleAddWallet();
                                }
                              }
                            : null,
                      ),
              ),
              isUpdate
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: ButtonText(
                        text: "Hapus Dompet",
                        textColor: primaryBlood,
                        textSize: 16,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
