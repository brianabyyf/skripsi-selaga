import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/components/auth_field.dart';
import 'package:selaga_ver1/pages/components/decoration.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/login_user_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;

  void _signInUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      var data = await ApiRepository().userLogin(LoginUserModel(
          email: _emailController.text, password: _passwordController.text));
      if (data.result != null && data.error == null) {
        if (!mounted) {
          return;
        }

        context.read<Token>().getToken(data.result!);
        context.go('/userHome');
      } else {
        _passwordController.clear();
        setState(() {
          _isSending = false;
        });
        if (!mounted) {
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
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  // logo
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      'assets/selaga-logo.png',
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Selamat Datang Kembali !',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: myAuthDecoration('Email'),
                      validator: (value) {
                        RegExp regex = RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                        if (value!.isEmpty) {
                          return 'Mohon isi kolom email';
                        } else {
                          if (!regex.hasMatch(value)) {
                            return 'Isi alamat email yang valid';
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  AuthField(
                    controller: _passwordController,
                    hintText: 'Kata sandi',
                    isObscureText: true,
                  ),

                  const SizedBox(height: 20),

                  // sign in button
                  InkWell(
                    onTap: _isSending ? null : _signInUser,
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
                                'Masuk',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
