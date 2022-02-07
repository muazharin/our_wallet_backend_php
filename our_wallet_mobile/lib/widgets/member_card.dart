import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/models/model_wallet.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class MemberCard extends StatefulWidget {
  const MemberCard({Key? key, required this.memberWalletModel})
      : super(key: key);
  final MemberWalletModel? memberWalletModel;
  @override
  _MemberCardState createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 16,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            widget.memberWalletModel!.userPhoto == ''
                ? ClipOval(
                    child: Container(
                      height: 56,
                      width: 56,
                      color: primaryBlood,
                      child: Center(
                        child: TextRegular(
                          text: widget.memberWalletModel!.userName!
                              .substring(0, 1)
                              .toUpperCase(),
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  )
                : ClipOval(
                    child: Image.network(
                      widget.memberWalletModel!.userPhoto!,
                      height: 56,
                      width: 56,
                      fit: BoxFit.contain,
                    ),
                  ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
