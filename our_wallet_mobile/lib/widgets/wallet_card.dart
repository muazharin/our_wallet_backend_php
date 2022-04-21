import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/models/model_wallet.dart';
import 'package:our_wallet_mobile/pages/wallets/detail_wallet.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';
import 'package:intl/intl.dart';

class WalletCard extends StatefulWidget {
  const WalletCard({Key? key, required this.walletModel}) : super(key: key);
  final WalletModel? walletModel;
  @override
  _WalletCardState createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  final currencyFormatter = NumberFormat("#,##0", "id_ID");
  WalletModel? walletModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            "assets/png/cards_${widget.walletModel!.walletColor}.png",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextBold(
                        text: widget.walletModel!.walletName,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    TextBold(
                      text: "OW Card",
                      color: Colors.white,
                      size: 14,
                    ),
                  ],
                ),
                Spacer(),
                TextBold(
                  text:
                      'Rp ${currencyFormatter.format(double.parse(widget.walletModel!.walletMoney!))}',
                  color: Colors.white,
                  size: 24,
                ),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailWallet(
                            walletModel: widget.walletModel,
                          ),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16,
                          ),
                          child: TextBold(
                            text: "Detail",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
