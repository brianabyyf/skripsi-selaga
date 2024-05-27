import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/repositories/providers.dart';
import 'package:selaga_ver1/repositories/routes.dart';

import 'pages/landing_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Token()),
      ChangeNotifierProvider(create: (context) => UserId()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // routerConfig: MyRoutes().router,
      debugShowCheckedModeBanner: false,
      title: 'SELAGA',
      home: LandingPage(),
    );
  }
}
