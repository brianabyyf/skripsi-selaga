import 'package:go_router/go_router.dart';
import 'package:selaga_ver1/pages/landing_page.dart';
import 'package:selaga_ver1/pages/mitra/mitra_login_page.dart';
import 'package:selaga_ver1/pages/mitra/mitra_register_page.dart';
import 'package:selaga_ver1/pages/user/home_page.dart';
import 'package:selaga_ver1/pages/user/login_page.dart';
import 'package:selaga_ver1/pages/user/register_page.dart';

class MyRoutes {
  final _router = GoRouter(routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const LandingPage(),
        routes: [
          GoRoute(
            path: 'userLogin',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: 'userRegister',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: 'mitraLogin',
            builder: (context, state) => const MitraLoginPage(),
          ),
          GoRoute(
            path: 'mitraRegister',
            builder: (context, state) => const MitraRegisterPage(),
          ),
        ]),
    GoRoute(
      path: '/userHome',
      builder: (context, state) => const HomePageNavigation(),
    ),
  ], initialLocation: '/landing', routerNeglect: true);

  GoRouter get router => _router;
}
