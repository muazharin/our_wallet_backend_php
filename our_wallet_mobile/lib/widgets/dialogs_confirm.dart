import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/loader.dart';
import 'package:our_wallet_mobile/widgets/primary_button.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

enum DialogAction { yes, abort }

class Dialogs {
  static Future<DialogAction> customLoader1(BuildContext? context,
      String? keterangan, String? info, Function()? onPressed) async {
    double width = MediaQuery.of(context!).size.width;
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: AlertDialog(
              insetPadding: EdgeInsets.zero,
              content: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Loader(
                            type: '',
                            spinSize: 72.0,
                            sizeCircle: 48.0,
                            widget: TextBold(
                              text: "?",
                              size: 24,
                              color: Colors.white,
                            ),
                            color: variantSunflower,
                          ),
                          SizedBox(height: 16.0),
                          TextRegular(
                            text: keterangan,
                            textAlign: TextAlign.center,
                            size: 16,
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: (width / 2.2) - 32.0,
                                child: ButtonPrimary(
                                  title: "Tidak",
                                  textSize: 14,
                                  textColor: primaryWater,
                                  bgColor: primaryWaterLight,
                                  hvColor: Colors.white,
                                  onTap: () {
                                    Navigator.of(context)
                                        .pop(DialogAction.abort);
                                  },
                                ),
                              ),
                              Container(
                                width: (width / 2.2) - 32.0,
                                child: ButtonPrimary(
                                  title: "Ya",
                                  textSize: 14,
                                  textColor: Colors.white,
                                  bgColor: primaryWater,
                                  hvColor: primaryWaterLight,
                                  onTap: onPressed,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}
