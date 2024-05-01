import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pemesanan"),
      ),
      body: const Column(
        children: [
          HistoryCard(),
          HistoryCard(),
          HistoryCard(),
          HistoryCard(),
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SizedBox(
            width: double.infinity,
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 8, top: 4),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lapangan A", style: TextStyle(fontSize: 16)),
                            SizedBox(height: 5),
                            Text("Lokasi Lapangan A")
                          ]))
                ])),
      ),
    );
  }
}
