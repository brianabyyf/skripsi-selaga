import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/components/auth_field.dart';
import 'package:selaga_ver1/pages/components/my_button.dart';

import 'home_page.dart';
import 'register_page.dart';

class MitraLoginPage extends StatefulWidget {
  const MitraLoginPage({super.key});

  @override
  State<MitraLoginPage> createState() => _MitraLoginPageState();
}

class _MitraLoginPageState extends State<MitraLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void signInUser() {
    if (formKey.currentState!.validate()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const MitraHomePageNavigation()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      'assets/selaga-logo.png',
                    ),
                  ),

                  // const Icon(
                  //   Icons.lock,
                  //   size: 100,
                  // ),

                  const SizedBox(height: 40),

                  // welcome back, you've been missed!
                  Text(
                    'Selamat Datang Kembali !',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // email textfield
                  AuthField(
                    controller: emailController,
                    hintText: 'Email',
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  AuthField(
                    controller: passwordController,
                    hintText: 'Password',
                    isObscureText: true,
                  ),

                  const SizedBox(height: 20),

                  // sign in button
                  MyButton(
                    onTap: signInUser,
                    buttonText: 'Login',
                  ),

                  const SizedBox(height: 50),

                  // not a member? register now
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MitraRegisterPage()),
                          );
                        },
                        child: const Text(
                          'Daftar di sini',
                          style: TextStyle(
                            color: Color.fromRGBO(76, 76, 220, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Login'),
  //     ),
  //     body: Form(
  //       key: formKey,
  //       child: Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             AuthField(hintText: "Email", controller: emailController),
  //             const SizedBox(height: 20.0),
  //             AuthField(
  //                 hintText: "Password",
  //                 controller: passwordController,
  //                 isObscureText: true),
  //             const SizedBox(height: 20.0),
  //             MyButton(onTap: signInUser, buttonText: "Login"),
  //             const SizedBox(height: 10.0),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => const MitraRegisterPage()),
  //                 );
  //               },
  //               child: const Text('Belum punya akun mitra? Daftar di sini'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
// }
