import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late int selected;

  @override
  void initState() {
    selected = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Jadwal'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Column(
                children: [
                  const Text('JANUARI 2024'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            selectedDayBox(selected),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: selectedDayBox2(selected),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: selectedDayBox3(selected))
                    ],
                  ),
                  const Spacer(),
                  Text('Tanggal yang dipilih'),
                  Text('19 Jan 2024')
                ],
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: JadwalView(
                  selected: selected,
                ),
              ),
            ),
            SizedBox(
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
                    onPressed: () {},
                    child: const Text(
                      'Pesan Sekarang',
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      )),
    );
  }

  GestureDetector selectedDayBox3(int boxSelected) {
    print(boxSelected.toString());
    if (boxSelected == 2) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selected = 2;
          });
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(color: Colors.purple),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            selected = 2;
          });
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(color: Colors.grey),
        ),
      );
    }
  }

  GestureDetector selectedDayBox2(int boxSelected) {
    print(boxSelected.toString());
    if (boxSelected == 1) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selected = 1;
          });
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(color: Colors.purple),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            selected = 1;
            boxSelected = 1;
          });
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(color: Colors.grey),
        ),
      );
    }
  }

  GestureDetector selectedDayBox(int boxSelected) {
    print(boxSelected.toString());
    if (boxSelected == 0) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selected = 0;
          });
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(color: Colors.purple),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            selected = 0;

            boxSelected = 0;
          });
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(color: Colors.grey),
        ),
      );
    }
  }
}

class JadwalView extends StatelessWidget {
  final int selected;
  const JadwalView({
    required this.selected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (selected == 0) {
      return Container(
        child: Text('0'),
      );
    } else if (selected == 1) {
      return Container(
        child: Text('1'),
      );
    } else {
      return Container(
        child: Text('2'),
      );
    }
  }
}
