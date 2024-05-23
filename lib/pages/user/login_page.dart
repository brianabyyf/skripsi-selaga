import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/components/auth_field.dart';
import 'package:selaga_ver1/pages/components/decoration.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/login_user_model.dart';
import 'home_page.dart';

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

      print(data.result);
      if (data.result != null) {
        String token = data.result!;
        if (!context.mounted) {
          return;
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePageNavigation(token: token)),
          (Route<dynamic> route) => false,
        );
      } else {
        _passwordController.clear();
        setState(() {
          _isSending = false;
        });
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email atau Password yang diberikan salah'),
            duration: Duration(milliseconds: 1100),
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
                          return 'Email can\'t be empty';
                        } else {
                          if (!regex.hasMatch(value)) {
                            return 'Enter valid email address';
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
                    hintText: 'Password',
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
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ),

                  // const SizedBox(height: 50),

                  // // not a member? register now
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Belum punya akun?',
                  //       style: TextStyle(color: Colors.grey[700]),
                  //     ),
                  //     const SizedBox(width: 2),
                  //     TextButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => const RegisterPage()),
                  //         );
                  //       },
                  //       child: const Text(
                  //         'Daftar di sini',
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
      ),
    );
  }
}
