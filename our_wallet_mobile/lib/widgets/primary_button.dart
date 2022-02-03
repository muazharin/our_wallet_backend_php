import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    Key? key,
    this.leading,
    this.trailing,
    this.title,
    this.bgColor,
    this.hvColor,
    this.textColor,
    this.textSize,
    this.padding,
    this.radius,
    this.onTap,
  }) : super(key: key);
  final Widget? leading;
  final Widget? trailing;
  final String? title;
  final Color? bgColor;
  final Color? hvColor;
  final Color? textColor;
  final double? textSize;
  final double? padding;
  final double? radius;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: bgColor ?? primaryColor,
        borderRadius: BorderRadius.circular(radius ?? 16.0),
        child: InkWell(
          onTap: onTap,
          splashColor: hvColor,
          child: Padding(
            padding: EdgeInsets.all(padding ?? 16.0),
            child: Row(
              children: [
                leading ?? Spacer(),
                SizedBox(width: 16.0),
                Center(
                  child: TextBold(
                    text: title,
                    color: textColor ?? Colors.white,
                    size: textSize,
                  ),
                ),
                SizedBox(width: 16.0),
                trailing ?? Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
