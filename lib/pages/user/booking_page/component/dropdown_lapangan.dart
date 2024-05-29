// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:selaga_ver1/repositories/api_repository.dart';
// import 'package:selaga_ver1/repositories/models/lapangan_model.dart';
// import 'package:selaga_ver1/repositories/models/venue_model.dart';
// import 'package:selaga_ver1/repositories/providers.dart';

// class MyLapanganDropDown extends StatefulWidget {
//   const MyLapanganDropDown({
//     super.key,
//     required this.myLapangan,
//   });

//   final List<Lapangan> myLapangan;

//   @override
//   State<MyLapanganDropDown> createState() => _MyLapanganDropDownState();
// }

// class _MyLapanganDropDownState extends State<MyLapanganDropDown> {
//   int? _dropdownValue;
//   // bool? tapped;
//   // int _selectedGridIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(left: 8.0),
//               child: Text(
//                 'Pilih Lapangan: ',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//             DropdownButton(
//               items: widget.myLapangan.map((e) {
//                 return DropdownMenuItem(
//                     value: e.id, child: Text(e.nameLapangan!));
//               }).toList(),
//               onChanged: (int? newValue) {
//                 setState(() {
//                   _dropdownValue = newValue!;
//                   Provider.of<LapanganId>(context, listen: false)
//                       .getLapanganId(_dropdownValue!);
//                 });
//               },
//               value: _dropdownValue,
//               borderRadius: BorderRadius.circular(10),
//               underline: const SizedBox(),
//             ),
//             // DropdownButton(
//             //   items: _items.map((String item) {
//             //     return DropdownMenuItem(value: item, child: Text(item));
//             //   }).toList(),
//             //   onChanged: (String? newValue) {
//             //     setState(() {
//             //       _dropdownValue = newValue!;
//             //     });
//             //   },
//             //   value: _dropdownValue,
//             //   borderRadius: BorderRadius.circular(10),
//             //   icon: const Icon(Icons.keyboard_arrow_down),
//             //   iconSize: 50,
//             //   style: TextStyle(fontSize: 30, color: Colors.black),
//             //   underline: Container(),
//             // ),
//           ],
//         ),
//         LapanganTimeHour(dropdownValue: _dropdownValue)
//       ],
//     );
//   }
// }

// class LapanganTimeHour extends StatefulWidget {
//   const LapanganTimeHour({
//     super.key,
//     required int? dropdownValue,
//   }) : _dropdownValue = dropdownValue;

//   final int? _dropdownValue;

//   @override
//   State<LapanganTimeHour> createState() => _LapanganTimeHourState();
// }

// class _LapanganTimeHourState extends State<LapanganTimeHour> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Token>(
//       builder: (context, myToken, child) => FutureBuilder(
//         future: ApiRepository().getJadwalLapangan(myToken.token),
//         builder: (context, snapshot) {
//           if (snapshot.hasData &&
//               snapshot.connectionState == ConnectionState.done) {
//             List<JadwalLapanganModel> jadwal = snapshot.data?.result ?? [];
//             List<JadwalLapanganModel> myJadwal = jadwal
//                 .where((e) => e.lapanganId == widget._dropdownValue)
//                 .toList();

//             List<String> hourList = [];

//             for (var e in myJadwal) {
//               var tempList = [];
//               if (e.days ==
//                   DateTime(
//                       DateTime.now().year,
//                       DateTime.now().month,
//                       DateTime.now().day +
//                           context.watch<SelectedDate>().selectedIndex)) {
//                 tempList = e.availableHour!.split(',').toList();
//                 // hourList.addAll(e.availableHour!);
//               }
//               for (var element in tempList) {
//                 hourList.add(element);
//               }
//             }
//             return SizedBox(
//               height: 220,
//               child: myJadwal.any((e) =>
//                       e.days ==
//                       DateTime(
//                           DateTime.now().year,
//                           DateTime.now().month,
//                           DateTime.now().day +
//                               Provider.of<SelectedDate>(context).selectedIndex))
//                   ? SizedBox(
//                       child: GridView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount:
//                                     4, // number of items in each row
//                                 mainAxisSpacing: 8.0, // spacing between rows
//                                 crossAxisSpacing:
//                                     8.0, // spacing between columns
//                                 childAspectRatio: (1 / .5)),
//                         padding: const EdgeInsets.all(
//                             8.0), // padding around the grid
//                         itemCount: hourList.length, // total number of items
//                         itemBuilder: (context, gridIndex) {
//                           // tapped = gridIndex == _selectedGridIndex;
//                           // &&
//                           // myJadwal[index].lapanganId.;

//                           return InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   // _selectedGridIndex = gridIndex;
//                                 });
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: const Color.fromARGB(
//                                         34, 158, 158, 158), //
//                                     // tapped!
//                                     //     ? const Color.fromRGBO(
//                                     //         76, 76, 220, 1)
//                                     //     : const Color.fromARGB(
//                                     //         34,
//                                     //         158,
//                                     //         158,
//                                     //         158), // color of grid items
//                                     borderRadius: BorderRadius.circular(8)),
//                                 child: Center(
//                                     child: Text(
//                                   '${hourList[gridIndex]} .00',
//                                   style: const TextStyle(fontSize: 16),
//                                 )
//                                     // Text('${hourList[gridIndex]}.00',
//                                     //     style: tapped!
//                                     //         ? const TextStyle(
//                                     //             fontSize: 18.0,
//                                     //             color: Colors.white)
//                                     //         : const TextStyle(
//                                     //             fontSize: 18.0)),
//                                     ),
//                               ));
//                         },
//                       ),
//                     )
//                   : const Center(child: Text('Jadwal Tidak Tersedia')),
//             );
//           } else if (snapshot.hasError) {
//             return Column(
//               children: [
//                 const Icon(
//                   Icons.error_outline,
//                   color: Colors.red,
//                   size: 60,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text('Error: ${snapshot.error}'),
//                 ),
//               ],
//             );
//           } else {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 60,
//                     height: 60,
//                     child: CircularProgressIndicator(),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 16),
//                     child: Text('Awaiting result...'),
//                   )
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
