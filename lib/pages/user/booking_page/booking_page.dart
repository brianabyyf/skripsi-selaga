import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:selaga_ver1/pages/user/booking_page/component/dropdown_lapangan.dart';
// import 'package:selaga_ver1/pages/user/booking_page/component/my_calendar.dart';
import 'package:selaga_ver1/pages/user/booking_page/component/venue_lapangan.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/lapangan_model.dart';
import 'package:selaga_ver1/repositories/models/user_profile_model.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class BookingPage extends StatelessWidget {
  final VenueModel venue;
  const BookingPage({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Jadwal'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Consumer<Token>(
            builder: (context, myToken, child) {
              return FutureBuilder(
                future: Future.wait([
                  ApiRepository().getMyLapangan(myToken.token, venue.id!),
                  ApiRepository().getJadwalLapangan(myToken.token),
                  ApiRepository().getMyProfile(myToken.token),
                ]),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    List<Lapangan> myLapangan = snapshot.data?[0].result ?? [];
                    List<JadwalLapanganModel> jadwal =
                        snapshot.data?[1].result ?? [];
                    UserProfileModel profile = snapshot.data?[2].result;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<OrderName>()
                          .update(profile.name ?? 'no name');
                    });
                    if (myLapangan.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline_outlined,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Tidak ada jadwal yang tersedia',
                              style: TextStyle(
                                  // color: Colors.red,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return VenueLapangan(
                          myLapangan: myLapangan, venue: venue, jadwal: jadwal);
                    }
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
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ));
  }
}

// class TimeViewLapangan extends StatefulWidget {
//   const TimeViewLapangan({
//     super.key,
//     required this.myLapangan,
//     required this.jadwal,
//   });

//   final List<Lapangan> myLapangan;
//   final List<JadwalLapanganModel2> jadwal;

//   @override
//   State<TimeViewLapangan> createState() => _TimeViewLapanganState();
// }

// class _TimeViewLapanganState extends State<TimeViewLapangan> {
//   bool? tapped;
//   int _selectedGridIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: ListView.builder(
//         itemCount: widget.myLapangan.length,
//         itemBuilder: (context, index) {
//           List<JadwalLapanganModel2> myJadwal = widget.jadwal
//               .where((e) => e.lapanganId == widget.myLapangan[index].id)
//               .toList();

//           List<String> hourList = [];

//           for (var e in myJadwal) {
//             var tempList = [];
//             if (e.days ==
//                 DateTime(
//                     DateTime.now().year,
//                     DateTime.now().month,
//                     DateTime.now().day +
//                         context.watch<SelectedDate>().selectedIndex)) {
//               tempList.addAll(e.availableHour!);
//               // hourList.addAll(e.availableHour!);
//             }
//             for (var element in tempList) {
//               hourList.add(element);
//             }
//           }

//           return Column(
//             children: [
//               Text('${widget.myLapangan[index].nameLapangan}'),
//               SizedBox(
//                 height: 220,
//                 child: myJadwal.any((e) =>
//                         e.days ==
//                         DateTime(
//                             DateTime.now().year,
//                             DateTime.now().month,
//                             DateTime.now().day +
//                                 Provider.of<SelectedDate>(context)
//                                     .selectedIndex))
//                     ? SizedBox(
//                         child: GridView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount:
//                                       4, // number of items in each row
//                                   mainAxisSpacing: 8.0, // spacing between rows
//                                   crossAxisSpacing:
//                                       8.0, // spacing between columns
//                                   childAspectRatio: (1 / .5)),
//                           padding: const EdgeInsets.all(
//                               8.0), // padding around the grid
//                           itemCount: hourList.length, // total number of items
//                           itemBuilder: (context, gridIndex) {
//                             tapped = gridIndex == _selectedGridIndex;
//                             // &&
//                             // myJadwal[index].lapanganId.;

//                             return InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     _selectedGridIndex = index;
//                                   });
//                                   print(myJadwal[index].lapanganId);
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color:
//                                           //const Color.fromARGB(
//                                           //         34, 158, 158, 158), //
//                                           tapped!
//                                               ? const Color.fromRGBO(
//                                                   76, 76, 220, 1)
//                                               : const Color.fromARGB(
//                                                   34,
//                                                   158,
//                                                   158,
//                                                   158), // color of grid items
//                                       borderRadius: BorderRadius.circular(8)),
//                                   child: Center(
//                                     child:
//                                         //     Text(
//                                         //   '${hourList[index]} .00',
//                                         //   style: const TextStyle(fontSize: 16),
//                                         // )
//                                         Text('${hourList[index]}.00',
//                                             style: tapped!
//                                                 ? const TextStyle(
//                                                     fontSize: 18.0,
//                                                     color: Colors.white)
//                                                 : const TextStyle(
//                                                     fontSize: 18.0)),
//                                   ),
//                                 ));
//                           },
//                         ),
//                       )
//                     : const Center(child: Text('Jadwal Tidak Tersedia')),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
