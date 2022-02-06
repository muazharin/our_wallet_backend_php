import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/primary_button.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({
    Key? key,
    required this.text,
    required this.textButton,
    required this.onTap,
  }) : super(key: key);
  final String? text;
  final String? textButton;
  final Function()? onTap;
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/confirm2.svg",
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 24),
                TextBold(text: widget.text, size: 14),
                SizedBox(height: 24),
                ButtonPrimary(
                  title: widget.textButton,
                  textSize: 16,
                  bgColor: primaryBlood,
                  hvColor: primaryBloodLight,
                  onTap: widget.onTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
