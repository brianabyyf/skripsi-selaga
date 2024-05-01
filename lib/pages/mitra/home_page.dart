import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/landing_page.dart';

class MitraHomePageNavigation extends StatefulWidget {
  const MitraHomePageNavigation({super.key});

  @override
  State<MitraHomePageNavigation> createState() =>
      _MitraHomePageNavigationState();
}

class _MitraHomePageNavigationState extends State<MitraHomePageNavigation> {
  List currentField = [];

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Anda belum mendaftarkan lapangan"),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Daftar'),
              )
            ],
          ),
        ));
  }
}
