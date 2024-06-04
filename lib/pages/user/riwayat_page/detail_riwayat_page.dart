import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/booking_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class DetailRiwayatPage extends StatelessWidget {
  const DetailRiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pemesanan'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Consumer2<Token, BookingId>(
        builder: (context, myToken, myBooking, child) => FutureBuilder(
          future: ApiRepository().getBookingDetail(myToken.token, myBooking.id),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              BookingModel booking = snapshot.data!.result!;
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    ListTile(
                      title: const Text('Nama Pemesan'),
                      // titleTextStyle: const TextStyle(
                      //     color: Colors.black, fontSize: 14),
                      subtitle: Text(booking.order?.name ?? ''),
                      // subtitleTextStyle: const TextStyle(
                      //   color: Colors.black,
                      //   fontSize: 25.0,
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                    ListTile(
                      title: const Text('Venue'),
                      titleTextStyle:
                          const TextStyle(color: Colors.black, fontSize: 14),
                      subtitle: Text(booking.lapangan?.nameVenue ?? ''),
                      subtitleTextStyle: const TextStyle(
                        color: Color.fromRGBO(76, 76, 220, 1),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const ListTile(
                    //   leading: Icon(Icons.location_on,
                    //       color: Color.fromRGBO(76, 76, 220, 1)),
                    //   title: Text('${booking.lapangan.}'),
                    // ),
                    ListTile(
                      title: const Text('Lapangan'),
                      // titleTextStyle: const TextStyle(
                      //     color: Colors.black, fontSize: 14),
                      subtitle: Text(booking.lapangan?.nameLapangan ?? ''),
                      // subtitleTextStyle: const TextStyle(
                      //   color: Colors.black,
                      //   fontSize: 25.0,
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                    ListTile(
                        leading: const Icon(Icons.calendar_month,
                            color: Color.fromRGBO(76, 76, 220, 1)),
                        title: Text(DateFormat('dd MMMM yyyy').format(DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day +
                                Provider.of<SelectedDate>(context,
                                        listen: false)
                                    .selectedIndex))),
                        subtitle: Text(
                            '${booking.hours!}.00 - ${1 + int.parse(booking.hours!)}.00'))
                  ]));
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
