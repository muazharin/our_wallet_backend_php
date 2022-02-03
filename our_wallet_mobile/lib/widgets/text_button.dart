import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    Key? key,
    @required this.text,
    this.textColor,
    this.width,
    this.textSize,
    this.icon,
    this.onTap,
  }) : super(key: key);
  final String? text;
  final Color? textColor;
  final double? width;
  final double? textSize;
  final Widget? icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? SizedBox(),
            TextBold(
              text: text,
              color: textColor ?? Colors.white,
              size: textSize,
            ),
          ],
        ),
      ),
    );
  }
}
