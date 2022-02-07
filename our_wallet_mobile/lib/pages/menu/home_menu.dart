import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:our_wallet_mobile/models/model_wallet.dart';
import 'package:our_wallet_mobile/services/service_wallet.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/member_card.dart';
import 'package:our_wallet_mobile/widgets/snackbar.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';
import 'package:our_wallet_mobile/widgets/wallet_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ResultWalletModel resultWalletModel = ResultWalletModel();
  List<WalletModel> list = [];
  ResultMemberWalletModel resultMemberWalletModel = ResultMemberWalletModel();
  List<MemberWalletModel> listmember = [];
  Map<String, dynamic> data = {};
  int indexList = 0;
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      data = {
        "id": sp.getInt("id"),
        "username": sp.getString("username"),
        "email": sp.getString("email"),
        "phone": sp.getString("phone"),
        "photo": sp.getString("photo"),
        "gender": sp.getString("gender"),
        "tgllahir": sp.getString("tgllahir"),
        "address": sp.getString("address"),
      };
    });
    getOurWallet();
  }

  getOurWallet() async {
    var params = {'userId': data['id']};
    WalletServices().getOurWallet(params).then((value) {
      if (value is String) {
        final snackBar = snackBarAlert('error', value);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        var result = jsonDecode(value.body);
        if (result['status']) {
          setState(() {
            resultWalletModel = ResultWalletModel.fromJson(result);
            list = resultWalletModel.data!;
          });
        }
        getMemberWallet();
      }
    });
  }

  getMemberWallet() async {
    print(indexList);
    var params = {'id': list[indexList].owWalletId};
    WalletServices().getMemberWallet(params).then((value) {
      if (value is String) {
        final snackBar = snackBarAlert('error', value);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        var result = jsonDecode(value.body);
        if (result['status']) {
          setState(() {
            resultMemberWalletModel = ResultMemberWalletModel.fromJson(result);
            listmember = resultMemberWalletModel.data!;
            print(listmember.length);
          });
        } else {
          final snackBar = snackBarAlert('error', "Terjadi Kesalahan");
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    });
  }

  Widget addCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 200,
        width: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: grayscaleStoneLight,
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: grayscaleStone,
            size: 48,
          ),
        ),
      ),
    );
  }

  Widget listCard() {
    return ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorColor: Colors.transparent,
      indicatorBackgroundColor: Colors.transparent,
      onPageChanged: (value) {
        setState(() {
          indexList = value;
        });
      },
      autoPlayInterval: 0,
      isLoop: false,
      children: list
          .map<Widget>((e) => Padding(
                padding: const EdgeInsets.only(left: 16),
                child: WalletCard(walletModel: e),
              ))
          .toList(),
    );
  }

  Widget listMemberCard() {
    return Row(
      children: listmember
          .map<Widget>((e) => Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: MemberCard(memberWalletModel: e),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBold(
                          text: "Our Wallet App",
                          size: 16,
                        ),
                        Icon(
                          Icons.notifications,
                          color: primaryBlood,
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    TextRegular(
                      text: "Halo, ${data['username'] ?? ''} :)",
                      size: 16,
                    ),
                  ],
                ),
              ),
              list.length == 0 ? addCard() : listCard(),
              SizedBox(height: 8),
              list == ''
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: list.asMap().entries.map((entry) {
                        return InkWell(
                          child: Container(
                            width: indexList == entry.key ? 24.0 : 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 2.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                              color: indexList == entry.key
                                  ? primaryBlood
                                  : grayscaleStone,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
              SizedBox(height: 8),
              listmember.length == 0
                  ? Center(child: TextRegular(text: "Tidak ada data ditemukan"))
                  : listMemberCard(),
            ],
          ),
        ),
      ),
    );
  }
}
