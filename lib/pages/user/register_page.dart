import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/components/auth_field.dart';
import 'package:selaga_ver1/pages/components/my_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
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
                const SizedBox(height: 10),

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
                const SizedBox(height: 10),
                AuthField(
                  controller: confirmController,
                  hintText: 'Confirm Password',
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
                        'Login disini',
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
}
