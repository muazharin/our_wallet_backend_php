import 'package:flutter/material.dart';
import 'package:our_wallet_mobile/pages/menu/history_menu.dart';
import 'package:our_wallet_mobile/pages/menu/home_menu.dart';
import 'package:our_wallet_mobile/pages/menu/profile_menu.dart';
import 'package:our_wallet_mobile/theme.dart';
// import 'package:our_wallet_mobile/pages/auth/auth_login.dart';
// import 'package:our_wallet_mobile/theme.dart';
// import 'package:our_wallet_mobile/widgets/primary_button.dart';
// import 'package:our_wallet_mobile/widgets/typography.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MainMenu extends StatefulWidget {
//   const MainMenu({Key? key}) : super(key: key);

//   @override
//   _MainMenuState createState() => _MainMenuState();
// }

// class _MainMenuState extends State<MainMenu> {
//   keluar() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     await sp.clear();
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(
//         builder: (context) => AuthLoginPage(),
//       ),
//       (Route<dynamic> route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextRegular(text: "Main Menu"),
//                 SizedBox(height: 24),
//                 ButtonPrimary(
//                   title: "Keluar",
//                   textSize: 16,
//                   bgColor: primaryBlood,
//                   hvColor: primaryBloodLight,
//                   onTap: () {
//                     keluar();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    History(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'Riwayat',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
                backgroundColor: Colors.white,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: primaryBlood,
            unselectedItemColor: grayscaleStone,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
