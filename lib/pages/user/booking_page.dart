import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selaga_ver1/pages/components/format.dart';
import 'package:selaga_ver1/pages/user/confirmation_page.dart';

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

  int selectedDate(int selected) {
    if (selected == 1) {
      return DateTime.now().day + 1;
    } else if (selected == 2) {
      return DateTime.now().day + 2;
    } else {
      return DateTime.now().day;
    }
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
                  Text('${DateTimeFormat.convertToString(DateTime.now().month)} ${DateTime.now().year}'),
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
                  Text('${selectedDate(selected)} ${DateTimeFormat.convertToString(DateTime.now().month)} ${DateTime.now().year}')
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
                  selected: selected
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DetailConfirmationPage()),
                      );

                    },
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('EEEE').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2))),
              Text('${DateTime.now().day + 2}')
            ],
          ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('EEEE').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2))),
              Text('${DateTime.now().day + 2}')
            ],
          ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('EEEE').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1))),
              Text('${DateTime.now().day + 1}')
            ],
          ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('EEEE').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1))),
              Text('${DateTime.now().day + 1}')
            ],
          ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('EEEE').format(DateTime.now())),
              Text('${DateTime.now().day}')
            ],
          ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('EEEE').format(DateTime.now())),
              Text('${DateTime.now().day}')
            ],
          ),
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
      return const TimeSlotView();
    } else {
      return const TimeSlotView();
    }
  }
}

class TimeSlotView extends StatefulWidget {

  const TimeSlotView({
    super.key,
  });

  @override
  State<TimeSlotView> createState() => _TimeSlotViewState();
}

class _TimeSlotViewState extends State<TimeSlotView> {
  int selectedGridIndex = -1;
  var dataList = {
    "lapangan": [
      {
        "id": 1,
        "jam": ['7', '8', '9', '10', '12', '13', '14', '15', '16', '17']
      },
      {
        "id": 2,
        "jam": ['13', '14', '15', '16', '17']
      },
      {
        "id": 3,
        "jam": ['12', '13', '14', '15', '16', '17']
      },
    ]
  };
  int _dropdownValue = 1;
  List items = [];

  @override
  void initState() {
    items = dataList['lapangan']![_dropdownValue - 1]['jam'] as List;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            const Text('Pilih Lapangan: '),
            DropdownButton(
              items: dataList['lapangan']!.map((e) {
                return DropdownMenuItem(
                    value: e['id'], child: Text(e['id'].toString()));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _dropdownValue = value as int;
                  items =
                      dataList['lapangan']![_dropdownValue - 1]['jam'] as List;
                  selectedGridIndex = -1;
                });
              },
              value: _dropdownValue,
              borderRadius: BorderRadius.circular(10),
              underline: const SizedBox(),
            ),
            // DropdownButton(
            //   items: _items.map((String item) {
            //     return DropdownMenuItem(value: item, child: Text(item));
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       _dropdownValue = newValue!;
            //     });
            //   },
            //   value: _dropdownValue,
            //   borderRadius: BorderRadius.circular(10),
            //   icon: const Icon(Icons.keyboard_arrow_down),
            //   iconSize: 50,
            //   style: TextStyle(fontSize: 30, color: Colors.black),
            //   underline: Container(),
            // ),
          ],
        ),
        jadwal(items)
      ],
    ));
  }

  SizedBox jadwal(List infoJam) {
    return SizedBox(
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
        itemCount: items.length, // total number of items
        itemBuilder: (context, index) {
          bool tapped = index == selectedGridIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedGridIndex = index;
              });
              print(_dropdownValue - 1);
              print(items[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                  color:
                      tapped ? Colors.blue : Colors.grey, // color of grid items
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  '${items[index]}.00',
                  style: const TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// class TimeSlotView extends StatefulWidget {
//   const TimeSlotView({
//     super.key,
//   });

//   @override
//   State<TimeSlotView> createState() => _TimeSlotViewState();
// }

// class _TimeSlotViewState extends State<TimeSlotView> {
//   int selectedGridIndex = 0;
//   late int selectedListIndex;
//   var dataList = {
//     "lapangan": [
//       {
//         "id": 1,
//         "jam": [7, 8, 9, 10, 12, 13, 14, 15, 16, 17]
//       },
//       {
//         "id": 2,
//         "jam": [13, 14, 15, 16, 17]
//       },
//       {
//         "id": 3,
//         "jam": [12, 13, 14, 15, 16, 17]
//       },
//     ]
//   };

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: ListView.builder(
//       shrinkWrap: true,
//       itemCount: dataList['lapangan']!.length,
//       itemBuilder: (context, index) {
//         Map<String, Object> info = dataList['lapangan']![index];
//         List infoJam = info['jam'] as List;
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Lapangan ${info['id']}'),
//                 Text('Rp 10.000 / jam')
//               ],
//             ),
//             SizedBox(
//               height: 170,
//               child: GridView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4, // number of items in each row
//                     mainAxisSpacing: 8.0, // spacing between rows
//                     crossAxisSpacing: 8.0, // spacing between columns
//                     childAspectRatio: (1 / .4)),
//                 padding: const EdgeInsets.all(8.0), // padding around the grid
//                 itemCount: infoJam.length, // total number of items
//                 itemBuilder: (context, index) {
//                   bool tapped = index == selectedGridIndex;
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedGridIndex = index;
//                       });
//                       print(info);
//                       print(selectedGridIndex);
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: tapped
//                               ? Colors.blue
//                               : Colors.grey, // color of grid items
//                           borderRadius: BorderRadius.circular(8)),
//                       child: const Center(
//                         child: Text(
//                           '07.00',
//                           style: TextStyle(fontSize: 18.0, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         );
//       },
//     ));
//   }
// }
