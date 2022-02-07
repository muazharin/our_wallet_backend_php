import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: TextRegular(
              text: "Riwayat",
              size: 14,
            ),
          ),
        ),
      ),
    );
  }
}
