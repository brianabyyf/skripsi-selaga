import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/components/auth_field.dart';
import 'package:selaga_ver1/pages/components/my_button.dart';

class MitraRegisterPage extends StatefulWidget {
  const MitraRegisterPage({super.key});

  @override
  State<MitraRegisterPage> createState() => _MitraRegisterPageState();
}

class _MitraRegisterPageState extends State<MitraRegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void signUpUser() {
    if (formKey.currentState!.validate()) {
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => const LoginPage()),
      //   (Route<dynamic> route) => false,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  color: Color.fromRGBO(76, 76, 220, 1),
                  Icons.app_registration_rounded,
                  size: 100,
                ),

                const SizedBox(height: 25),
                Text(
                  'Jadilah Bagian dari Komunitas Kami ',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Buat akun sekarang dan nikmati manfaatnya!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 35),

                AuthField(
                  controller: nameController,
                  hintText: 'Nama Lengkap',
                ),
                const SizedBox(height: 10),
                AuthField(
                  controller: emailController,
                  hintText: 'Email',
                ),
                const SizedBox(height: 10),
                AuthField(
                  controller: phoneController,
                  hintText: 'Nomor Handphone',
                ),
                const SizedBox(height: 10),
                AuthField(
                  controller: passwordController,
                  hintText: 'Password',
                  isObscureText: true,
                ),
                const SizedBox(height: 20),
                MyButton(
                  onTap: signUpUser,
                  buttonText: 'Register',
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 2),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Login di sini',
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
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Register'),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const TextField(
  //             decoration: InputDecoration(
  //               labelText: 'Nama',
  //             ),
  //           ),
  //           const SizedBox(height: 20.0),
  //           const TextField(
  //             decoration: InputDecoration(
  //               labelText: 'Email',
  //             ),
  //           ),
  //           const SizedBox(height: 20.0),
  //           const TextField(
  //             decoration: InputDecoration(
  //               labelText: 'Nomor Handphone',
  //             ),
  //           ),
  //           const SizedBox(height: 20.0),
  //           const TextField(
  //             obscureText: true,
  //             decoration: InputDecoration(
  //               labelText: 'Password',
  //             ),
  //           ),
  //           const SizedBox(height: 20.0),
  //           ElevatedButton(
  //             onPressed: () {
  //               // Tambahkan logika untuk registrasi di sini
  //             },
  //             child: const Text('Register'),
  //           ),
  //           const SizedBox(height: 10.0),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Sudah punya akun? Login di sini'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
