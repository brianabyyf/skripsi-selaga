import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/components/auth_field.dart';
import 'package:selaga_ver1/pages/mitra/mitra_navigation_page.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/register_user_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class MitraRegisterPage extends StatefulWidget {
  const MitraRegisterPage({super.key});

  @override
  State<MitraRegisterPage> createState() => _MitraRegisterPageState();
}

class _MitraRegisterPageState extends State<MitraRegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;

  void _signUpUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      var data = await ApiRepository().mitraRegister(RegisterUserModel(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text));
      if (data.result != null) {
        if (!context.mounted) {
          return;
        }
        context.read<Token>().getToken(data.result!);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const MitraHomePageNavigation()),
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() {
          _isSending = false;
        });
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data.error}'),
            duration: const Duration(milliseconds: 1200),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  'Jadilah Bagian dari Mitra Kami ',
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
                  controller: _nameController,
                  hintText: 'Nama Lengkap',
                ),
                const SizedBox(height: 10),
                AuthField(
                  controller: _emailController,
                  hintText: 'Email',
                ),
                const SizedBox(height: 10),
                AuthField(
                  controller: _phoneController,
                  hintText: 'Nomor Handphone',
                ),
                const SizedBox(height: 10),
                AuthField(
                  controller: _passwordController,
                  hintText: 'Password',
                  isObscureText: true,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: _isSending ? null : _signUpUser,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(76, 76, 220, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: _isSending
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Sudah punya akun?',
                //       style: TextStyle(color: Colors.grey[700]),
                //     ),
                //     const SizedBox(width: 2),
                //     TextButton(
                //       onPressed: () {
                //         Navigator.pop(context);
                //       },
                //       child: const Text(
                //         'Login disini',
                //         style: TextStyle(
                //           color: Color.fromRGBO(76, 76, 220, 1),
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // )
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
