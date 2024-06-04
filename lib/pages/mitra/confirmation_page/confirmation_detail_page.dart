import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/booking_model.dart';
import 'package:selaga_ver1/repositories/models/endpoints.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class MitraDetailConfirmation extends StatefulWidget {
  const MitraDetailConfirmation({super.key});

  @override
  State<MitraDetailConfirmation> createState() =>
      _MitraDetailConfirmationState();
}

class _MitraDetailConfirmationState extends State<MitraDetailConfirmation> {
  var _isSending = false;

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
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: const Text('Nama Pemesan'),
                            titleTextStyle: const TextStyle(
                                color: Colors.black, fontSize: 14),
                            subtitle: Text(booking.order?.name ?? ''),
                            subtitleTextStyle: const TextStyle(
                              color: Color.fromRGBO(76, 76, 220, 1),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListTile(
                            title: const Text('Venue'),
                            // titleTextStyle: const TextStyle(
                            //     color: Colors.black, fontSize: 14),
                            subtitle: Text(booking.lapangan?.nameVenue ?? ''),
                            // subtitleTextStyle: const TextStyle(
                            //   color: Colors.black,
                            //   fontSize: 25.0,
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),
                          ListTile(
                            title: const Text('Lapangan'),
                            // titleTextStyle: const TextStyle(
                            //     color: Colors.black, fontSize: 14),
                            subtitle:
                                Text(booking.lapangan?.nameLapangan ?? ''),
                            // subtitleTextStyle: const TextStyle(
                            //   color: Colors.black,
                            //   fontSize: 25.0,
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),
                          ListTile(
                              leading: const Icon(Icons.calendar_month,
                                  color: Color.fromRGBO(76, 76, 220, 1)),
                              title: Text(DateFormat('dd MMMM yyyy').format(
                                  DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day +
                                          Provider.of<SelectedDate>(context,
                                                  listen: false)
                                              .selectedIndex))),
                              subtitle: Text(
                                  '${booking.hours!}.00 - ${1 + int.parse(booking.hours!)}.00')),
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text('Bukti Pembayaran'),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      final width =
                                          MediaQuery.of(context).size.width;
                                      final height =
                                          MediaQuery.of(context).size.height;
                                      return AlertDialog(
                                        content: Stack(
                                          children: [
                                            SizedBox(
                                              width: width * 0.9,
                                              height: height * 0.9,
                                              child: Image.network(
                                                '${Endpoints().payment}${booking.image}',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      shape: BoxShape.circle),
                                                  child: Icon(
                                                    CupertinoIcons.xmark,
                                                    color: Colors.white
                                                        .withOpacity(0.9),
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        insetPadding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.zero,
                                        // clipBehavior:
                                        //     Clip.antiAliasWithSaveLayer,
                                      );
                                    },
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    '${Endpoints().payment}${booking.image}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    booking.confirmation == 'pending'
                        ? Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: SizedBox(
                                    // width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12))),
                                        onPressed: () {},
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ))),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                    // width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    76, 76, 220, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12))),
                                        onPressed: () async {
                                          var data = await ApiRepository()
                                              .updateBooking(
                                                  token: myToken.token,
                                                  id: myBooking.id);
                                          if (data.result != null) {
                                            // context.goNamed(
                                            //     'mitra_detail_konfirmasi');
                                            setState(() {});
                                          } else {
                                            print(data.error);
                                          }
                                        },
                                        child: const Text(
                                          'Confirm',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ))),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              );
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
