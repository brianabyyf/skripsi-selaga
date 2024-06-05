import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selaga_ver1/pages/components/my_button.dart';
import 'package:selaga_ver1/pages/mitra/mitra_navigation_page.dart';

class SuccesssDaftarVenuePage extends StatelessWidget {
  const SuccesssDaftarVenuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 120,
                      color: Color.fromRGBO(76, 76, 220, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Venue Berhasil ditambahkan!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              )),
          MyButton(
              onTap: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const MitraHomePageNavigation()),
                //   // (Route<dynamic> route) => false,
                // );
                context.goNamed('mitra_home');
              },
              buttonText: 'Kembali ke Halaman Utama')
        ],
      ),
    )));
  }
}
