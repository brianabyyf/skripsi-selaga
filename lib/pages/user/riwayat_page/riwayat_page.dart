import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/booking_model.dart';
import 'package:selaga_ver1/repositories/models/user_profile_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Riwayat Pemesanan"),
      ),
      body: SafeArea(
          child: Consumer<Token>(
        builder: (context, mytoken, child) => FutureBuilder(
          future: Future.wait([
            ApiRepository().getMyProfile(mytoken.token),
            ApiRepository().getBooking(mytoken.token)
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              UserProfileModel profile = snapshot.data?[0].result;
              List<BookingModel> booking = snapshot.data?[1].result ?? [];
              List<BookingModel> myBooking =
                  booking.where((e) => profile.id == e.order!.id).toList();
              if (myBooking.isEmpty) {
                return const Center(
                  child: Text('Anda belum memiliki riwayat booking'),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: myBooking.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            // ArgumentsUser args = ArgumentsUser(
                            //     venue: venue,
                            //     lapangan: myLapangan[index],
                            //     listJadwal: myJadwal);
                            // args.toJson();

                            // context.goNamed('user_lapangan_detail',
                            //     extra: args);
                            if (myBooking[index].confirmation == 'pending') {
                              return;
                            } else {
                              Provider.of<BookingId>(context, listen: false)
                                  .updateBookingId(myBooking[index].id ?? 0);
                              context.goNamed('user_detail_pemesanan');
                            }
                            // context.goNamed('user_detail_pemesanan');
                          },
                          child: Container(
                            // height: 125,
                            height: 150,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  myBooking[index].lapangan?.nameVenue ?? '',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                  // maxLines: 1,
                                ),
                                ListTile(
                                    leading: const Icon(Icons.calendar_month),
                                    title: Text(DateFormat('dd MMMM yyyy')
                                        .format(DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day +
                                                Provider.of<SelectedDate>(
                                                        context,
                                                        listen: false)
                                                    .selectedIndex))),
                                    subtitle: Text(
                                        '${myBooking[index].hours}.00 - ${1 + int.parse(myBooking[index].hours!)}.00')),
                                myBooking[index].confirmation == 'pending'
                                    ? const Text(
                                        'Harap menunggu konfirmasi dari pihak penyewa',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(76, 76, 220, 1)),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SizedBox(
            width: double.infinity,
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 8, top: 4),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lapangan A", style: TextStyle(fontSize: 16)),
                            SizedBox(height: 5),
                            Text("Lokasi Lapangan A")
                          ]))
                ])),
      ),
    );
  }
}
