import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet_mobile/models/model_wallet.dart';
import 'package:our_wallet_mobile/pages/menu/main_menu.dart';
import 'package:our_wallet_mobile/services/service_wallet.dart';
import 'package:our_wallet_mobile/utils/form_validation.dart';
import 'package:our_wallet_mobile/widgets/dialogs_confirm.dart';
import 'package:our_wallet_mobile/widgets/input_text.dart';
import 'package:our_wallet_mobile/widgets/loading_shimmer.dart';
import 'package:our_wallet_mobile/widgets/profile_photo.dart';
import 'package:our_wallet_mobile/widgets/snackbar.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMemberWallet extends StatefulWidget {
  const AddMemberWallet({Key? key, required this.owWalletId}) : super(key: key);
  final String? owWalletId;
  @override
  _AddMemberWalletState createState() => _AddMemberWalletState();
}

class _AddMemberWalletState extends State<AddMemberWallet> {
  TextEditingController keyword = TextEditingController(text: "");
  ResultUserToWalletModel resultUserToWalletModel = ResultUserToWalletModel();
  List<UserToWalletModel> list = [];
  bool isLoading = false;

  handleListUser() async {
    setState(() {
      isLoading = true;
    });
    var params = {
      "owWalletId": widget.owWalletId!,
      "keyword": keyword.text,
    };
    WalletServices().getUserToWallet(params).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value is String) {
        final snackBar = snackBarAlert('error', value);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        var result = jsonDecode(value.body);
        if (result['status']) {
          setState(() {
            resultUserToWalletModel = ResultUserToWalletModel.fromJson(result);
            list = resultUserToWalletModel.data!;
          });
        }
      }
    });
  }

  handleAddMemberWallet(UserToWalletModel e) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      "userId": sp.getInt("id").toString(),
      "memberId": e.userId,
    };
    var params = {
      "owWalletId": widget.owWalletId,
    };
    WalletServices().addMemberWallet(body, params).then((value) {
      if (value is String) {
        final snackBar = snackBarAlert('error', value);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        var result = jsonDecode(value.body);
        if (result['status']) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainMenu()),
              (route) => false);
          final snackBar = snackBarAlert('success', result['message']);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    });
  }

  Widget cardMember(UserToWalletModel e) {
    return InkWell(
      onTap: () {
        Dialogs.customLoader1(
          context,
          "Tambahkan ${e.userName} ke member?",
          "",
          () async {
            handleAddMemberWallet(e);
          },
        );
      },
      child: ListTile(
        leading: ProfilePhoto(photo: e.userPhoto, name: e.userName),
        title: TextRegular(text: e.userEmail, size: 12),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextRegular(text: e.userName, size: 12),
            TextRegular(text: e.userPhone, size: 12),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    handleListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBold(
                        text: "Tambah Member",
                        size: 24,
                      ),
                      SizedBox(height: 24),
                      TextInput(
                        hintText: "Masukkan Nama, Telpon atau Email",
                        controller: keyword,
                        validator: validationString,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          handleListUser();
                        },
                        onChange: (v) {
                          if (v.isEmpty) {
                            handleListUser();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LoadingShimmer.rectangular(
                            height: 56.0,
                            width: double.infinity,
                          ),
                        ),
                      )
                    : list.length == 0
                        ? Column(
                            children: [
                              SizedBox(height: 64),
                              SvgPicture.asset(
                                "assets/svg/notfound.svg",
                                width: 150,
                                height: 150,
                              ),
                              SizedBox(height: 24),
                              TextRegular(
                                text: "User tidak ditemukan",
                                size: 14,
                              ),
                            ],
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: list.map((e) => cardMember(e)).toList(),
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
