import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/components/my_button.dart';
import 'package:selaga_ver1/pages/mitra/lapangan_page/lapangan_page.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';

class SuccesssDaftarLapanganPage extends StatelessWidget {
  final VenueModel venue;
  const SuccesssDaftarLapanganPage({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 250,
                      color: Color.fromRGBO(76, 76, 220, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Lapangan Berhasil ditambahkan!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              )),
          MyButton(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyLapanganPage(venue: venue)),
                );
              },
              buttonText: 'Kembali ke Halaman Utama')
        ],
      ),
    )));
  }
}
