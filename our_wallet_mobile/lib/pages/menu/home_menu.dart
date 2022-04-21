import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_wallet_mobile/models/model_transaction.dart';
import 'package:our_wallet_mobile/models/model_wallet.dart';
import 'package:our_wallet_mobile/pages/auth/auth_login.dart';
import 'package:our_wallet_mobile/pages/wallets/create_wallet.dart';
import 'package:our_wallet_mobile/services/service_wallet.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/dialogs_confirm.dart';
import 'package:our_wallet_mobile/widgets/loading_shimmer.dart';
import 'package:our_wallet_mobile/widgets/member_card.dart';
import 'package:our_wallet_mobile/widgets/snackbar.dart';
import 'package:our_wallet_mobile/widgets/text_button.dart';
import 'package:our_wallet_mobile/widgets/transaction_card.dart';
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
  ResultTransactionModel resultTransactionModel = ResultTransactionModel();
  List<TransactionModel> listtransaction = [];
  Map<String, dynamic> data = {};
  int indexList = 0;
  bool isLoadingCard = false;
  bool isLoadingMember = false;

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
    setState(() {
      isLoadingCard = true;
    });
    var params = {'userId': data['id']};
    WalletServices().getOurWallet(params).then((value) {
      setState(() {
        isLoadingCard = false;
      });
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
    if (list.length == 0) {
      setState(() => isLoadingMember = false);
    } else {
      setState(() => isLoadingMember = true);
      var params = {'id': list[indexList].owWalletId};
      WalletServices().getMemberWallet(params).then((value) {
        if (value is String) {
          setState(() {
            isLoadingMember = false;
          });
          final snackBar = snackBarAlert('error', value);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var result = jsonDecode(value.body);
          if (result['status']) {
            setState(() {
              resultMemberWalletModel =
                  ResultMemberWalletModel.fromJson(result);
              listmember = resultMemberWalletModel.data!;
              getLastTransaction();
            });
          } else {
            setState(() {
              isLoadingMember = false;
            });
            final snackBar = snackBarAlert('error', "Terjadi Kesalahan");
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      });
    }
  }

  getLastTransaction() async {
    var params = {
      'walletId': list[indexList].owWalletId,
      'userId': '',
      'page': 1,
    };
    WalletServices().getTransactionWallet(params).then((value) {
      setState(() {
        isLoadingMember = false;
      });
      if (value is String) {
        final snackBar = snackBarAlert('error', value);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        var result = jsonDecode(value.body);
        if (result['status']) {
          setState(() {
            resultTransactionModel = ResultTransactionModel.fromJson(result);
            listtransaction = resultTransactionModel.data!;
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
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => CreateWallet(),
          ))
              .then((_) {
            getInit();
          });
        },
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
          getMemberWallet();
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

  Widget listTransactionCard() {
    return Column(
      children: listtransaction
          .map<Widget>((e) => TransactionCard(transactionModel: e))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              Dialogs.customLoader1(
                context,
                "Yakin ingin keluar?",
                "",
                () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  await sp.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => AuthLoginPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                Icons.notifications,
                color: primaryBlood,
              ),
            ),
          )
        ],
        title: TextBold(
          text: "Our Wallet App",
          size: 16,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRegular(
                        text: "Halo, ${data['username'] ?? ''} :)",
                        size: 16,
                      ),
                    ],
                  ),
                ),
                isLoadingCard
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LoadingShimmer.rectangular(
                            height: 200.0,
                            width: 320.0,
                          ),
                        ),
                      )
                    : list.length == 0
                        ? addCard()
                        : listCard(),
                SizedBox(height: 8),
                isLoadingCard == ''
                    ? SizedBox()
                    : list == ''
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
                isLoadingMember
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LoadingShimmer.rectangular(
                            height: 80.0,
                            width: 80.0,
                          ),
                        ),
                      )
                    : listmember.length == 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Center(
                                child: TextRegular(
                                    text: "Tidak ada data ditemukan")),
                          )
                        : listMemberCard(),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBold(text: "Transaksi Terakhir"),
                          ButtonText(text: "Lainnya", textColor: primaryBlood),
                        ],
                      ),
                    ],
                  ),
                ),
                isLoadingMember
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LoadingShimmer.rectangular(
                            height: 56.0,
                          ),
                        ),
                      )
                    : listtransaction.length == 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Center(
                                child: TextRegular(
                                    text: "Tidak ada data ditemukan")),
                          )
                        : listTransactionCard(),
                SizedBox(height: 56),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: primaryBlood,
        overlayOpacity: 0.5,
        spacing: 8,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            child: Icon(Icons.remove, color: grayscaleCharcoal),
            label: "Debit",
            labelStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: grayscaleCharcoal,
              fontSize: 12.0,
            ),
          ),
          SpeedDialChild(
            child: Icon(Icons.add, color: grayscaleCharcoal),
            label: "Kredit",
            labelStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: grayscaleCharcoal,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
