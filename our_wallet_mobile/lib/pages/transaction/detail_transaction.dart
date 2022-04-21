import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/models/model_transaction.dart';
import 'package:our_wallet_mobile/services/service_call_center.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/primary_button.dart';
import 'package:our_wallet_mobile/widgets/profile_photo.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';
import 'package:intl/intl.dart';

class DetailTransaction extends StatefulWidget {
  const DetailTransaction({Key? key, this.transactionModel}) : super(key: key);
  final TransactionModel? transactionModel;
  @override
  _DetailTransactionState createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  final currencyFormatter = NumberFormat("#,##0", "id_ID");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBold(
                text: "Detail Transaksi",
                size: 24,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      TextBold(text: "Detail User"),
                      SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfilePhoto(
                            photo: widget.transactionModel!.userDetail!.photo,
                            name: widget.transactionModel!.userDetail!.name,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextBold(
                                  text:
                                      widget.transactionModel!.userDetail!.name,
                                ),
                                TextRegular(
                                  text: widget
                                      .transactionModel!.userDetail!.email,
                                ),
                                TextRegular(
                                  text: widget
                                      .transactionModel!.userDetail!.phone,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      TextBold(text: "Detail Transaksi"),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 1,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextRegular(text: "Judul"),
                              TextRegular(
                                text: widget
                                    .transactionModel!.transactionDetail!.title,
                              ),
                              SizedBox(height: 8),
                              TextRegular(text: "Detail"),
                              TextRegular(
                                text: widget.transactionModel!
                                    .transactionDetail!.detail,
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextRegular(text: "Tipe"),
                                  widget.transactionModel!.type == "Kredit"
                                      ? TextRegular(
                                          text: widget.transactionModel!.type,
                                          color: variantCactus,
                                        )
                                      : TextRegular(
                                          text: widget.transactionModel!.type,
                                          color: variantSunflower,
                                        ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextRegular(text: "Waktu"),
                                  TextRegular(
                                      text:
                                          DateFormat("dd MMM yy hh:mm").format(
                                    widget.transactionModel!.transactionDetail!
                                        .date!,
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: grayscaleCharcoal,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 1,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextBold(
                                text: "Total Harga",
                                color: Colors.white,
                              ),
                              TextRegular(
                                text:
                                    "Rp ${currencyFormatter.format(double.parse(widget.transactionModel!.transactionDetail!.price!))}",
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextBold(text: "Sumber Dana"),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              "assets/png/cards_${widget.transactionModel!.walletDetail!.color!}.png",
                              width: 80,
                              height: 50,
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextBold(
                                text:
                                    widget.transactionModel!.walletDetail!.name,
                                size: 14,
                              ),
                              SizedBox(height: 8),
                              TextRegular(
                                text: "Our Wallet App",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ButtonPrimary(
                  title: "Hubungi Kami",
                  textSize: 14,
                  hvColor: primaryBloodLight,
                  onTap: () => Callcenter().openWa(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
