import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/user/payment_page/payment_page.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/arguments.dart';
import 'package:selaga_ver1/repositories/models/lapangan_model.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class DetailConfirmationPage extends StatefulWidget {
  const DetailConfirmationPage(
      {super.key,
      required this.myJadwal,
      required this.lapangan,
      required this.venue});

  final List<JadwalLapanganModel> myJadwal;
  final Lapangan lapangan;
  final VenueModel venue;

  @override
  State<DetailConfirmationPage> createState() => _DetailConfirmationPageState();
}

class _DetailConfirmationPageState extends State<DetailConfirmationPage> {
  var _isSending = false;

  @override
  Widget build(BuildContext context) {
    String selectedHour =
        Provider.of<SelectedHour>(context, listen: false).selectedHour.join();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Lapangan mu',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Waktu'),
              ListTile(
                  leading: const Icon(Icons.calendar_month,
                      color: Color.fromRGBO(76, 76, 220, 1)),
                  title: Text(DateFormat('dd MMMM yyyy').format(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day +
                          Provider.of<SelectedDate>(context, listen: false)
                              .selectedIndex))),
                  subtitle: Text(
                      '$selectedHour.00 - ${1 + int.parse(selectedHour)}.00')),
              ListTile(
                  leading: const Icon(Icons.location_pin,
                      color: Color.fromRGBO(76, 76, 220, 1)),
                  title: Text(widget.venue.nameVenue ?? ''),
                  subtitle: Text(widget.lapangan.nameLapangan ?? '')),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:'),
                    Text('Rp. ${widget.venue.price}' ?? '0')
                  ],
                ),
              )
            ]),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(76, 76, 220, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: _isSending
                        ? null
                        : () async {
                            setState(() {
                              _isSending = true;
                            });

                            final token =
                                Provider.of<Token>(context, listen: false)
                                    .token;

                            final JadwalLapanganModel dataJadwal =
                                widget.myJadwal.firstWhere((e) =>
                                    e.days ==
                                    DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day +
                                            Provider.of<SelectedDate>(context,
                                                    listen: false)
                                                .selectedIndex));

                            List<String> tempHour = Provider.of<HourAvailable>(
                                    context,
                                    listen: false)
                                .hour;

                            tempHour.remove(selectedHour);

                            final availableHour = tempHour.join(',');

                            print(availableHour);
                            print(selectedHour);
                            print(_isSending);

                            var data = await ApiRepository().postEditJadwal(
                                token: token,
                                data: dataJadwal,
                                availableHour: availableHour,
                                unavailableHour: selectedHour);

                            ArgumentsUser args = ArgumentsUser(
                                venue: widget.venue,
                                lapangan: widget.lapangan,
                                listJadwal: widget.myJadwal);
                            args.toJson();
                            context.goNamed('user_lapangan_payment',
                                extra: args);
                          },
                    child: _isSending
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Lanjutkan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ))),
          ],
        ),
      )),
    );
  }
}
