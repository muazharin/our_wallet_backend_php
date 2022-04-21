import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/dot.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
    @required this.type,
    this.spinSize,
    this.sizeCircle,
    this.color,
    this.widget,
  }) : super(key: key);
  final String? type;
  final double? spinSize;
  final double? sizeCircle;
  final Color? color;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SpinKitPulse(
          color: color ?? variantCactus,
          size: spinSize ?? 80,
        ),
        Dot(radius: 50, color: color ?? variantCactus),
        widget!,
      ],
    );
  }
}
