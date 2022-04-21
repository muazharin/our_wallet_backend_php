import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:our_wallet_mobile/models/model_wallet.dart';
import 'package:our_wallet_mobile/pages/wallets/add_member_wallet.dart';
import 'package:our_wallet_mobile/pages/wallets/create_wallet.dart';
import 'package:our_wallet_mobile/services/service_wallet.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/loading_shimmer.dart';
import 'package:our_wallet_mobile/widgets/profile_photo.dart';
import 'package:our_wallet_mobile/widgets/snackbar.dart';
import 'package:our_wallet_mobile/widgets/text_button.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class DetailWallet extends StatefulWidget {
  const DetailWallet({Key? key, required this.walletModel}) : super(key: key);
  final WalletModel? walletModel;
  @override
  _DetailWalletState createState() => _DetailWalletState();
}

class _DetailWalletState extends State<DetailWallet> {
  ResultMemberWalletModel resultMemberWalletModel = ResultMemberWalletModel();
  List<MemberWalletModel> listmember = [];
  final currencyFormatter = NumberFormat("#,##0", "id_ID");
  bool isLoadingMember = false;
  @override
  void initState() {
    getMemberWallet();
    super.initState();
  }

  getMemberWallet() async {
    setState(() => isLoadingMember = true);
    var params = {'id': widget.walletModel!.owWalletId};
    WalletServices().getMemberWallet(params).then((value) {
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
            resultMemberWalletModel = ResultMemberWalletModel.fromJson(result);
            listmember = resultMemberWalletModel.data!;
            // getLastTransaction();
          });
        } else {
          final snackBar = snackBarAlert('error', "Terjadi Kesalahan");
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    });
  }

  Widget detail({field, content, color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: TextRegular(text: field, size: 12),
          ),
          Expanded(
            child: TextRegular(
              text: content,
              textAlign: TextAlign.end,
              size: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget cardMember(MemberWalletModel e) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: primaryBlood,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
            label: 'Hapus',
          ),
        ],
      ),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextBold(
                        text: "Detail Dompet",
                        size: 24,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateWallet(
                              walletModel: widget.walletModel,
                            ),
                          ));
                        },
                        child: Icon(Icons.edit_outlined, color: primaryBlood),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/png/cards_${widget.walletModel!.walletColor!}.png",
                                height: 200,
                                width: 320,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 320,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Spacer(),
                                    Row(
                                      children: [
                                        Spacer(),
                                        TextBold(
                                          text: "OW Card",
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        TextBold(text: "Keterangan", size: 12),
                        SizedBox(height: 16),
                        detail(
                          field: "Nama Dompet",
                          content: widget.walletModel!.walletName,
                        ),
                        detail(
                          field: "Saldo",
                          content:
                              "Rp ${currencyFormatter.format(double.parse(widget.walletModel!.walletMoney!))}",
                        ),
                        detail(
                          field: "Dibuat",
                          content: DateFormat("dd MMM yy hh:mm").format(
                            widget.walletModel!.walletCreatedAt!,
                          ),
                        ),
                        detail(
                          field: "Diperbarui",
                          content: DateFormat("dd MMM yy hh:mm").format(
                            widget.walletModel!.walletUpdatedAt!,
                          ),
                        ),
                        detail(
                          field: "Status",
                          content: widget.walletModel!.walletIsActive! == "1"
                              ? "Aktif"
                              : "Tidak Aktif",
                          color: widget.walletModel!.walletIsActive! == "1"
                              ? variantCactus
                              : primaryBlood,
                        ),
                        SizedBox(height: 16),
                        TextBold(text: "Administrator", size: 12),
                        SizedBox(height: 16),
                        isLoadingMember
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: LoadingShimmer.rectangular(
                                  height: 56.0,
                                  width: double.infinity,
                                ),
                              )
                            : Column(
                                children: listmember
                                    .expand((e) =>
                                        [if (e.owIsAdmin == "1") cardMember(e)])
                                    .toList(),
                              ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextBold(text: "Member", size: 12),
                            ButtonText(
                              text: "Tambah Member",
                              textSize: 12,
                              textColor: primaryBlood,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddMemberWallet(
                                    owWalletId: widget.walletModel!.owWalletId,
                                  ),
                                ));
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        isLoadingMember
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: LoadingShimmer.rectangular(
                                  height: 56.0,
                                  width: double.infinity,
                                ),
                              )
                            : Column(
                                children: listmember
                                    .expand((e) =>
                                        [if (e.owIsAdmin != "1") cardMember(e)])
                                    .toList(),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
