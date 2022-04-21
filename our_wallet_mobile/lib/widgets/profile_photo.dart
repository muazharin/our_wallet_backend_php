import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    Key? key,
    required this.photo,
    required this.name,
    this.size,
  }) : super(key: key);
  final String? photo;
  final String? name;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: photo == ""
          ? ClipOval(
              child: Container(
                width: size ?? 56,
                height: size ?? 56,
                color: primaryBlood,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: TextBold(
                      text: name![0].toUpperCase(),
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          : ClipOval(
              child: Image.network(
                photo!,
                width: size ?? 56,
                height: size ?? 56,
                fit: BoxFit.contain,
              ),
            ),
    );
  }
}
