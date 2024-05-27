import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/mitra/daftar_venue/daftar_venue_page.dart';

class NoVenue extends StatelessWidget {
  const NoVenue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Anda belum memiliki Venue',
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(width: 2),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DaftarVenuePage()),
              );
            },
            child: const Text(
              'Daftar disini',
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
