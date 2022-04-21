import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    Key? key,
    @required this.groupValue,
    this.onChanged,
    this.value = "",
    this.text,
    this.toggle = true,
  }) : super(key: key);
  final Object? groupValue;
  final Object value;
  final String? text;
  final bool toggle;
  final Function(Object?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      toggleable: toggle,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: TextRegular(
        size: 14,
        text: text,
        color: grayscaleCharcoal,
      ),
    );
  }
}
