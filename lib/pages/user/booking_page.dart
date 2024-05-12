import 'package:flutter/material.dart';

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
                  const Text('Tanggal yang dipilih'),
                  const Text('19 Jan 2024')
                ],
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            const Text("Lapangan Tersedia"),
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
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(8)),
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
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  GestureDetector selectedDayBox2(int boxSelected) {
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
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(8)),
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
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  GestureDetector selectedDayBox(int boxSelected) {
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
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(8)),
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
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(8)),
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
      return const TimeSlotView();
    } else if (selected == 1) {
      return const Text('1');
    } else {
      return const Text('2');
    }
  }
}

class TimeSlotView extends StatelessWidget {
  const TimeSlotView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Lapangan A'), Text('Rp 10.000 / jam')],
            ),
            SizedBox(
              height: 170,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // number of items in each row
                    mainAxisSpacing: 8.0, // spacing between rows
                    crossAxisSpacing: 8.0, // spacing between columns
                    childAspectRatio: (1 / .4)),
                padding: const EdgeInsets.all(8.0), // padding around the grid
                itemCount: 12, // total number of items
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue, // color of grid items
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          '07.00',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    ),
                    onTap: () {
                      print(index);
                    },
                  );
                },
              ),
            )
          ],
        );
      },
    ));
  }
}
