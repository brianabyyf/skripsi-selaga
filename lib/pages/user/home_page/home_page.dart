import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selaga_ver1/pages/user/home_page/components/by_populer.dart';
import 'package:selaga_ver1/pages/user/home_page/components/list_by_rating.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/repositories/models/booking_model.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Consumer<Token>(
        builder: (context, mytoken, child) => FutureBuilder(
          future: Future.wait([
            ApiRepository().getAllVenue(mytoken.token),
            ApiRepository().getBooking(mytoken.token),
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              List<VenueModel> venue = snapshot.data?[0].result ?? [];

              List<BookingModel> bookings = snapshot.data?[1].result ?? [];

              // venue.sort((a, b) => double.parse(b.rating ?? '0')
              //     .compareTo(double.parse(a.rating ?? '0')));
              // venue.sort((a, b) => -a.rating!.compareTo(b.rating!));

              if (venue.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 8),
                        child: Text('Lokasi'),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color.fromRGBO(76, 76, 220, 1),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Bandung, Indonesia',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                        child: SearchBarTheme(
                          data: SearchBarThemeData(
                              surfaceTintColor:
                                  MaterialStatePropertyAll(Colors.grey)),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: SearchBar(
                              leading: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Berdasarkan Rating',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.goNamed('user_venue_byrating');
                              },
                              child: const Text(
                                'Lihat semua',
                                style: TextStyle(
                                  color: Color.fromRGBO(76, 76, 220, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      VenueByRating(
                        venue: venue,
                        bookings: bookings,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Tempat populer',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.goNamed('user_venue_bypopuler');
                              },
                              child: const Text(
                                'Lihat semua',
                                style: TextStyle(
                                  color: Color.fromRGBO(76, 76, 220, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      VenueByPopuler(venue: venue, booking: bookings)
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('Belum ada venue yang tersedia'),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      )),
    );
  }
}
