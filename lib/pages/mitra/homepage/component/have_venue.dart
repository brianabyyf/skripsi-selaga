import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/mitra/daftar_venue/daftar_venue_page.dart';
import 'package:selaga_ver1/pages/mitra/venue_detail/venue_detail_page.dart';
import 'package:selaga_ver1/repositories/models/arguments.dart';
import 'package:selaga_ver1/repositories/models/endpoints.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class HaveVenue extends StatelessWidget {
  const HaveVenue({
    super.key,
    required this.myVenue,
  });

  final List<VenueModel> myVenue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: myVenue.length,
            itemBuilder: (context, index) {
              var img = myVenue[index].image;
              var imgList = img?.split(',');

              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => MitraDetailPage(
                    //             venueId: myVenue[index].id ?? 0,
                    //           )),
                    // );
                    Provider.of<SelectedDate>(context, listen: false)
                        .getSelectedIndex(0);

                    ArgumentsMitra args = ArgumentsMitra(
                        venueId: myVenue[index].id,
                        venue: myVenue[index],
                        lapangan: myVenue[index].lapangans,
                        selectedDateIndex: 0,
                        listLapangan: myVenue[index].lapangans,
                        listJadwal: []);
                    args.toJson();
                    context.goNamed('mitra_detail_venue', extra: args);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: myVenue[index].image!.isNotEmpty
                                ? Image.network(
                                    '${Endpoints().image}${imgList?.first}',
                                    height: 140,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 140,
                                    height: 140,
                                    decoration:
                                        const BoxDecoration(color: Colors.grey),
                                    child: const Icon(Icons.error_outline),
                                  )),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                myVenue[index].nameVenue ?? '',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                                // maxLines: 1,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                myVenue[index].lokasiVenue!,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                                // maxLines: 1,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                'Rating ${myVenue[index].rating}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                                // maxLines: 1,
                              ),
                            ],
                          ),
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
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(76, 76, 220, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const DaftarVenuePage()),
                    // );
                    context.goNamed('mitra_daftar_venue');
                  },
                  child: const Text(
                    'Tambah Venue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ))),
        ),
      ],
    );
  }
}
