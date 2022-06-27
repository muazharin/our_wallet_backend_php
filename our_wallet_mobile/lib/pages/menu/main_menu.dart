import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/pages/menu/history_menu.dart';
import 'package:our_wallet_mobile/pages/menu/home_menu.dart';
import 'package:our_wallet_mobile/pages/menu/profile_menu.dart';
import 'package:our_wallet_mobile/theme.dart';
import 'package:our_wallet_mobile/widgets/typography.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    History(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 16,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                // ignore: deprecated_member_use
                // title: selectedIndex == 0
                //     ? TextBold(
                //         text: 'Beranda',
                //         color: primaryBlood,
                //       )
                //     : TextRegular(
                //         text: 'Beranda',
                //         color: grayscaleStone,
                //       ),
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                // ignore: deprecated_member_use
                // title: selectedIndex == 1
                //     ? TextBold(
                //         text: 'Riwayat',
                //         color: primaryBlood,
                //       )
                //     : TextRegular(
                //         text: 'Riwayat',
                //         color: grayscaleStone,
                //       ),
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                // ignore: deprecated_member_use
                // title: selectedIndex == 2
                //     ? TextBold(
                //         text: 'Profil',
                //         color: primaryBlood,
                //       )
                //     : TextRegular(
                //         text: 'Profil',
                //         color: grayscaleStone,
                //       ),
                backgroundColor: Colors.white,
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: primaryBlood,
            unselectedItemColor: grayscaleStone,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
