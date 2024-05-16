import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/mitra/mitra_login_page.dart';
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
          children: <Widget>[
            Expanded(
              child: Image.asset(
                'assets/field_b.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 25, left: 25, right: 25),
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
                    padding:
                        const EdgeInsets.only(top: 25, left: 25, right: 25),
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
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                side: const BorderSide(width: 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            child: const Text('Masuk'),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                side: const BorderSide(width: 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MitraLoginPage()),
                              );
                            },
                            child: const Text('Masuk sebagai Mitra'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Belum punya akun?',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 2),
                            TextButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const RegisterPage()),
                                // );
                              },
                              child: const Text(
                                'Daftar disini',
                                style: TextStyle(
                                  color: Color.fromRGBO(76, 76, 220, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 25,
            // ),
            // const SizedBox(
            //   height: 25,
            // ),
            // TextButton(
            //   style: const ButtonStyle(
            //       foregroundColor:
            //           MaterialStatePropertyAll(Color.fromRGBO(76, 76, 220, 1))),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const MitraLoginPage()),
            //     );
            //   },
            //   child: const Text('Masuk sebagai Mitra'),
            // ),
          ],
        ),
      ),
    );
  }
}
