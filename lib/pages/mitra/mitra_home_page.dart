import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:selaga_ver1/pages/landing_page.dart';
import 'package:selaga_ver1/pages/mitra/daftar_venue_page.dart';

class MitraHomePageNavigation extends StatefulWidget {
  const MitraHomePageNavigation({super.key});

  @override
  State<MitraHomePageNavigation> createState() =>
      _MitraHomePageNavigationState();
}

class _MitraHomePageNavigationState extends State<MitraHomePageNavigation> {
  int _currentIndexPage = 0;
  List currentField = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const MitraHomePage(),
        const ConfirmationPage(),
        const MemberPage(),
        const MitraProfilePage()
      ][_currentIndexPage],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: GNav(
            // rippleColor: const Color.fromRGBO(76, 76, 220, 0.5),
            // hoverColor: const Color.fromRGBO(76, 76, 220, 0.5),
            gap: 8,
            color: Colors.grey,
            activeColor: const Color.fromRGBO(76, 76, 220, 1),
            tabBackgroundColor: const Color.fromRGBO(76, 76, 220, 0.25),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            iconSize: 24,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Beranda',
              ),
              GButton(
                icon: Icons.view_list_rounded,
                text: 'Konfirmasi',
              ),
              GButton(
                icon: Icons.card_membership_sharp,
                text: 'Member',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              )
            ],
            selectedIndex: _currentIndexPage,
            onTabChange: (index) {
              setState(() {
                _currentIndexPage = index;
              });
            },
          ),
        )),
      ),
    );
  }
}

class MitraHomePage extends StatelessWidget {
  const MitraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mitra Selaga'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LandingPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Anda belum memiliki Venue',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 2),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DaftarVenuePage()),
                    );
                  },
                  child: const Text(
                    'Daftar disini',
                    style: TextStyle(
                      color: Color.fromRGBO(76, 76, 220, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MitraProfilePage extends StatelessWidget {
  const MitraProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
