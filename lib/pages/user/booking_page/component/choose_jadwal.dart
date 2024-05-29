import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/user/booking_page/component/hour_section.dart';
import 'package:selaga_ver1/pages/user/booking_page/component/my_calendar.dart';
import 'package:selaga_ver1/pages/user/confirmation_page.dart';
import 'package:selaga_ver1/repositories/models/lapangan_model.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class ChooseJadwalPage extends StatelessWidget {
  const ChooseJadwalPage(
      {super.key,
      required this.myJadwal,
      required this.lapangan,
      required this.venue});
  final List<JadwalLapanganModel> myJadwal;
  final Lapangan lapangan;
  final VenueModel venue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Jadwal'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  BookingCalendar(
                    myJadwal: myJadwal,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Harga',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              '00',
                              style: TextStyle(
                                  color: const Color.fromRGBO(76, 76, 220, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(' /jam')
                          ],
                        )
                      ],
                    ),
                  ),
                  HourSection(
                      myJadwal: myJadwal, lapangan: lapangan, venue: venue)
                ],
              ),
            ),
            myJadwal.any((e) =>
                    e.days ==
                    DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day +
                            Provider.of<SelectedDate>(context, listen: false)
                                .selectedIndex))
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(76, 76, 220, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DetailConfirmationPage()),
                          );
                        },
                        child: const Text(
                          'Pesan Sekarang',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )))
                : Container()
          ],
        ),
      )),
    );
  }
}