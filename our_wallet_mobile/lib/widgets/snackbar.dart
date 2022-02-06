import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

SnackBar snackBarAlert(
  String type,
  String message,
) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    backgroundColor: type == 'success'
        ? variantCactus
        : type == 'info'
            ? variantSunflower
            : primaryBlood,
    content: Container(
      // height: 16.0,
      child: Row(
        children: [
          type == 'success' ? SizedBox() : SizedBox(),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextRegular(
              text: message,
              color: Colors.white,
            ),
          )
        ],
      ),
    ),
    action: SnackBarAction(
      label: 'Close',
      textColor: Colors.white,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}
