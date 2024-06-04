import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/mitra/detail_lapangan/detail_lapangan_page.dart';
import 'package:selaga_ver1/pages/mitra/lapangan_page/component/edit_lapangan.dart';
import 'package:selaga_ver1/pages/mitra/lapangan_page/component/tambah_lapangan.dart';
import 'package:selaga_ver1/repositories/models/arguments.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class HaveLapangan extends StatelessWidget {
  final List<Lapangan> myLapangan;
  final VenueModel venue;
  const HaveLapangan(
      {super.key, required this.myLapangan, required this.venue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: myLapangan.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                child: InkWell(
                  onTap: () {
                    // Provider.of<SelectedDate>(context, listen: false)
                    //     .getSelectedIndex(0);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => DetailLapanganPage(
                    //             // idLapangan: myLapangan[index].id ?? 0,
                    //             // namaLapangan:
                    //             //     myLapangan[index].nameLapangan ?? '',
                    //             lapangan: myLapangan[index],
                    //             venue: venue, selectedDateIndex: 0,
                    //             // myLapangan: JadwalLapanganModel.fromJson(myLapangan[index] as Map<String, dynamic>),
                    //           )),
                    // );
                    ArgumentsMitra args = ArgumentsMitra(
                        venueId: venue.id,
                        venue: venue,
                        lapangan: myLapangan[index],
                        selectedDateIndex: 0);
                    args.toJson();
                    context.goNamed('mitra_lapangan_detail', extra: args);
                  },
                  child: Container(
                    height: 85,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              myLapangan[index].nameLapangan ?? '',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                              // maxLines: 1,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditMyLapanganPage(
                                                    venue: venue,
                                                    myLapangan:
                                                        myLapangan[index])),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit_calendar,
                                      color: Color.fromRGBO(76, 76, 220, 1),
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TambahLapanganPage(
                        venue: venue, myLapangan: myLapangan)),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              // margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(76, 76, 220, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Tambah Lapangan',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
