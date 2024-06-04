import 'package:go_router/go_router.dart';
import 'package:selaga_ver1/pages/landing_page.dart';
import 'package:selaga_ver1/pages/mitra/daftar_venue/daftar_venue_page.dart';
import 'package:selaga_ver1/pages/mitra/detail_lapangan/detail_lapangan_page.dart';
import 'package:selaga_ver1/pages/mitra/lapangan_page/lapangan_page.dart';
import 'package:selaga_ver1/pages/mitra/mitra_login_page.dart';
import 'package:selaga_ver1/pages/mitra/mitra_navigation_page.dart';
import 'package:selaga_ver1/pages/mitra/mitra_register_page.dart';
import 'package:selaga_ver1/pages/mitra/success_daftar_venue_page.dart';
import 'package:selaga_ver1/pages/mitra/venue_detail/venue_detail_page.dart';
import 'package:selaga_ver1/pages/user/home_page.dart';
import 'package:selaga_ver1/pages/user/login_page.dart';
import 'package:selaga_ver1/pages/user/register_page.dart';
import 'package:selaga_ver1/repositories/models/arguments.dart';

class MyRoutes {
  final _router = GoRouter(
    routes: [
      GoRoute(
          path: '/landing',
          name: 'landing_page',
          builder: (context, state) => const LandingPage(),
          routes: [
            GoRoute(
              path: 'userLogin',
              name: 'user_login',
              builder: (context, state) => const LoginPage(),
            ),
            GoRoute(
              path: 'userRegister',
              name: 'user_register',
              builder: (context, state) => const RegisterPage(),
            ),
            GoRoute(
              path: 'mitraLogin',
              name: 'mitra_login',
              builder: (context, state) => const MitraLoginPage(),
            ),
            GoRoute(
              path: 'mitraRegister',
              name: 'mitra_register',
              builder: (context, state) => const MitraRegisterPage(),
            ),
          ]),
      GoRoute(
        path: '/userHome',
        name: 'user_home',
        builder: (context, state) => const HomePageNavigation(),
      ),
      GoRoute(
          path: '/mitraHome',
          name: 'mitra_home',
          builder: (context, state) => const MitraHomePageNavigation(),
          routes: [
            GoRoute(
                path: 'mitraDaftarVenue',
                name: 'mitra_daftar_venue',
                builder: (context, state) => const DaftarVenuePage(),
                routes: [
                  GoRoute(
                    path: 'mitraDaftarVenueSuccess',
                    name: 'mitra_daftar_venue_success',
                    builder: (context, state) =>
                        const SuccesssDaftarVenuePage(),
                  ),
                ]),
            GoRoute(
                path: 'mitraDetailVenue',
                name: 'mitra_detail_venue',
                builder: (context, state) {
                  ArgumentsMitra args = state.extra as ArgumentsMitra;
                  return MitraDetailPage(venueId: args.venueId!);
                },
                routes: [
                  GoRoute(
                      path: 'myLapangPage',
                      name: 'mitra_lapangan_page',
                      builder: (context, state) {
                        ArgumentsMitra args = state.extra as ArgumentsMitra;
                        return MyLapanganPage(
                          venue: args.venue!,
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'myLapanganDetail',
                          name: 'mitra_lapangan_detail',
                          builder: (context, state) {
                            ArgumentsMitra args = state.extra as ArgumentsMitra;
                            return DetailLapanganPage(
                                lapangan: args.lapangan!,
                                venue: args.venue!,
                                selectedDateIndex: args.selectedDateIndex!);
                          },
                        )
                      ]),
                ]),
          ])
    ],
    initialLocation: '/mitraHome/mitraDaftarVenue/mitraDaftarVenueSuccess',
    routerNeglect: true,
    debugLogDiagnostics: true,
  );

  GoRouter get router => _router;
}
