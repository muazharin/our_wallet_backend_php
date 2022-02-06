import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/theme.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    Key? key,
    this.bgColor,
  }) : super(key: key);
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: bgColor ?? primaryBlood,
        borderRadius: BorderRadius.circular(16.0),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16.0,
                  height: 16.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
