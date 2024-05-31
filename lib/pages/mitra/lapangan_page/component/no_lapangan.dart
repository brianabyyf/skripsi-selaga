import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/mitra/lapangan_page/component/tambah_lapangan.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';

class NoLapangan extends StatelessWidget {
  final VenueModel venue;
  final List<Lapangan> myLapangan;
  const NoLapangan({
    super.key,
    required this.myLapangan,
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
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TambahLapanganPage(
                          venue: venue,
                          myLapangan: myLapangan,
                        )),
              );
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
