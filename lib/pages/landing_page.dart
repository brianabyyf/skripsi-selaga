import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/mitra/login_page.dart';
import 'package:selaga_ver1/pages/user/login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'assets/field_b.jpg',
              fit: BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat datang di',
                    style: TextStyle(color: Colors.black, fontSize: 24.0),
                  ),
                  Text(
                    'SELAGA',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Pesan lapangan dengan mudah, dimanapun, dan kapanpun.',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mulai..',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.email),
                      label: const Text('Masuk dengan email'),
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          side: const BorderSide(width: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        // TODO: Implement Email Sign-In functionality
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 25,
            ),
            TextButton(
              style: const ButtonStyle(
                  foregroundColor:
                      MaterialStatePropertyAll(Color.fromRGBO(76, 76, 220, 1))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MitraLoginPage()),
                );
              },
              child: const Text('Masuk sebagai Mitra'),
            ),
          ],
        ),
      ),
    );
  }
}
