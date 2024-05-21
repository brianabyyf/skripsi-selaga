import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/components/auth_field.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/register_user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;

  void _signUpUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      var data = await ApiRepository().userRegister(RegisterUserModel(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text));
      print(data.error);

      if (data.result != null) {
        if (!context.mounted) {
          return;
        }
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => const HomePageNavigation()),
        //   (Route<dynamic> route) => false,
        // );
      } else {
        setState(() {
          _isSending = false;
        });
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email atau Nomor Handphone sudah digunakan'),
            duration: Duration(milliseconds: 1100),
          ),
        );
      }

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
            key: _formKey,
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
                const SizedBox(height: 10),
                AuthField(
                  controller: _confirmController,
                  hintText: 'Confirm Password',
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
