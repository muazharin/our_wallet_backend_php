import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/models/model_transaction.dart';
import 'package:our_wallet_mobile/pages/transaction/detail_transaction.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/profile_photo.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({Key? key, this.transactionModel}) : super(key: key);
  final TransactionModel? transactionModel;
  final currencyFormatter = NumberFormat("#,##0", "id_ID");
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailTransaction(
            transactionModel: transactionModel,
          ),
        ));
      },
      child: ListTile(
        leading: ProfilePhoto(
          photo: transactionModel!.userDetail!.photo,
          name: transactionModel!.userDetail!.name,
          size: 48,
        ),
        title: TextRegular(text: transactionModel!.userDetail!.name),
        subtitle: TextRegular(
            text: DateFormat("dd MMM yy hh:mm")
                .format(transactionModel!.transactionDetail!.date!)),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextRegular(text: transactionModel!.type),
            SizedBox(height: 4),
            transactionModel!.type == "Kredit"
                ? TextBold(
                    text:
                        '+ Rp ${currencyFormatter.format(double.parse(transactionModel!.transactionDetail!.price!))}',
                    color: variantCactus,
                  )
                : TextBold(
                    text:
                        '- Rp ${currencyFormatter.format(double.parse(transactionModel!.transactionDetail!.price!))}',
                    color: variantSunflower,
                  ),
          ],
        ),
      ),
    );
  }
}
