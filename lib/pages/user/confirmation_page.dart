import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/user/payment_page.dart';

class DetailConfirmationPage extends StatelessWidget {
  const DetailConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lapangan mu',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Waktu'),
                  ListTile(
                      leading: Icon(Icons.calendar_month),
                      title: Text('17 Mei 2024'),
                      subtitle: Text('8.00 - 9.00')),
                  ListTile(
                      leading: Icon(Icons.location_pin),
                      title: Text('Lokasi Venue'),
                      subtitle: Text('Lapangan 1')),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Total:'), Text('Rp 80.000')],
                    ),
                  )
                ]),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(76, 76, 220, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentPage()),
                      );
                    },
                    child: const Text(
                      'Lanjutkan',
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      )),
    );
  }
}
