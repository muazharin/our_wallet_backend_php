import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: TextRegular(
              text: "Profil",
              size: 14,
            ),
          ),
        ),
      ),
    );
  }
}
