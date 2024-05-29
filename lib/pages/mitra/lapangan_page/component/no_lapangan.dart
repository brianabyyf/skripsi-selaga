import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/mitra/lapangan_page/lapangan_page.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class NoLapangan extends StatelessWidget {
  final VenueModel venue;
  final List<Lapangan> myLapangan;
  final int venueId;
  const NoLapangan({
    super.key,
    required this.myLapangan,
    required this.venueId,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Anda belum menambahkan Lapangan',
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(width: 2),
          TextButton(
            onPressed: () async {
              final mytoken = Provider.of<Token>(context, listen: false).token;

              var data = await ApiRepository().daftarLapangan(
                  mytoken, 'Lapangan ${myLapangan.length + 1}', venueId);

              if (data.result != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyLapanganPage(
                            venueId: venueId,
                            venue: venue,
                          )),
                );
              }
            },
            child: const Text(
              'Tambah disini',
              style: TextStyle(
                color: Color.fromRGBO(76, 76, 220, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
