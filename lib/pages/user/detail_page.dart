import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/user/booking_page.dart';

class FieldDetailPage extends StatefulWidget {
  final String fieldName;

  const FieldDetailPage({super.key, required this.fieldName});

  @override
  State<FieldDetailPage> createState() => _FieldDetailPageState();
}

class _FieldDetailPageState extends State<FieldDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detail'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
              Row(
                children: [
                  Container(
                    height: 25,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 25,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 25,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('5.0')
                      ],
                    ),
                  )
                ],
              ),
              const Text(
                'Nama Tempat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Row(
                children: [
                  Text(
                    'Rp. ',
                    style: TextStyle(color: Color.fromRGBO(76, 76, 220, 1)),
                  ),
                  Text(
                    '10000',
                    style: TextStyle(color: Color.fromRGBO(76, 76, 220, 1)),
                  ),
                  Text(' /jam',
                      style: TextStyle(
                        color: Colors.grey,
                      ))
                ],
              ),
              const Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color.fromRGBO(76, 76, 220, 1),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('lokasi'),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              const Text('Preview',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              ),
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
                              builder: (context) => const BookingPage()),
                        );
                      },
                      child: const Text(
                        'Pesan Sekarang',
                        style: TextStyle(color: Colors.white),
                      ))),

              // const Text(
              //   'Jam Tersedia untuk Disewakan',
              //   style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 20.0),
              // Expanded(
              //   child: ListView(
              //     children: [
              //       TimeSlotItem(
              //           time: '08:00 - 10:00',
              //           onPressed: () {
              //             // Tambahkan logika untuk menyewa pada jam ini
              //           }),
              //       TimeSlotItem(
              //           time: '10:00 - 12:00',
              //           onPressed: () {
              //             // Tambahkan logika untuk menyewa pada jam ini
              //           }),
              //       TimeSlotItem(
              //           time: '12:00 - 14:00',
              //           onPressed: () {
              //             // Tambahkan logika untuk menyewa pada jam ini
              //           }),
              //       // Tambahkan jam-jam lainnya sesuai kebutuhan
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
