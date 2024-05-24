import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:selaga_ver1/pages/user/booking_page.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/lapangan_model.dart';

class FieldDetailPage extends StatefulWidget {
  final int id;
  final String token;

  const FieldDetailPage({
    super.key,
    required this.id,
    required this.token,
  });

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
        child: FutureBuilder(
          future: ApiRepository().getLapanganDetail(widget.token, widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return DetailWidget(
                venue: snapshot.data!.result!,
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailWidget extends StatelessWidget {
  final DetailLapanganModel venue;
  const DetailWidget({
    super.key,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    var img = venue.image;
    var imgList = img?.split(',');

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://192.168.0.106/skripsi-selaga/storage/app/image/${imgList!.first}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                height: 25,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 25,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 25,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
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
          Text(
            venue.name!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Text(
                'Rp. ',
                style: TextStyle(color: Color.fromRGBO(76, 76, 220, 1)),
              ),
              Text(
                venue.price!,
                style: const TextStyle(color: Color.fromRGBO(76, 76, 220, 1)),
              ),
              const Text(' /jam',
                  style: TextStyle(
                    color: Colors.grey,
                  ))
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Color.fromRGBO(76, 76, 220, 1),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(venue.address!),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Preview',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          'http://192.168.0.106/skripsi-selaga/storage/app/image/${imgList[index]}',
                          fit: BoxFit.cover),
                    ),
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
        ],
      ),
    );
  }
}
