import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/mitra/detail_lapangan/detail_lapangan_page.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class AturJadwalPage extends StatefulWidget {
  final Lapangan lapangan;
  final VenueModel venue;
  const AturJadwalPage(
      {super.key, required this.venue, required this.lapangan});

  @override
  State<AturJadwalPage> createState() => _AturJadwalPageState();
}

class _AturJadwalPageState extends State<AturJadwalPage> {
  late int selectedDateIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedDateIndex = Provider.of<SelectedDate>(context).selectedIndex;
  }

  final List<int> _hour = [
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22
  ];
  List<int> _hourSelected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Atur Jadwal ${DateFormat('d MMM, yyyy').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + Provider.of<SelectedDate>(context, listen: false).selectedIndex))}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Text(
                    'Atur jam yang tersedia:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (_hourSelected.isNotEmpty) {
                          if (_hourSelected.length < 16) {
                            List<int> tempHour = [];
                            for (var e in _hour) {
                              tempHour.add(e);
                            }
                            _hourSelected = tempHour.toSet().toList();
                          } else {
                            _hourSelected.clear();
                          }
                        } else {
                          for (var e in _hour) {
                            _hourSelected.add(e);
                          }
                        }
                      });
                    },
                    child: Container(
                      height: 42,
                      width: 90,
                      decoration: BoxDecoration(
                          color: _hourSelected.length == 16
                              ? const Color.fromRGBO(76, 76, 220, 1)
                              : const Color.fromARGB(34, 158, 158, 158),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                        'Semua',
                        style: _hourSelected.length == 16
                            ? const TextStyle(fontSize: 16, color: Colors.white)
                            : const TextStyle(fontSize: 16),
                      )),
                    ),
                  ),
                  SizedBox(
                      height: 210,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      4, // number of items in each row
                                  mainAxisSpacing: 8.0, // spacing between rows
                                  crossAxisSpacing:
                                      8.0, // spacing between columns
                                  childAspectRatio: (1 / .5)),
                          padding: const EdgeInsets.all(
                              8.0), // padding around the grid
                          itemCount: _hour.length, // total number of items
                          itemBuilder: (context, index) {
                            // bool tapped = index == _selectedGridIndex;
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_hourSelected.contains(_hour[index])) {
                                      _hourSelected.remove(_hour[index]);
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   const SnackBar(
                                      //     content: Text('Jam sudah dipilih'),
                                      //     duration:
                                      //         Duration(milliseconds: 1200),
                                      //   ),
                                      // );
                                    } else {
                                      _hourSelected.add(_hour[index]);
                                    }
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            _hourSelected.contains(_hour[index])
                                                ? const Color.fromRGBO(
                                                    76, 76, 220, 1)
                                                : const Color.fromARGB(
                                                    34,
                                                    158,
                                                    158,
                                                    158), // color of grid items
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                        child:
                                            _hourSelected.contains(_hour[index])
                                                ? Text(
                                                    '${_hour[index]}.00',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  )
                                                : Text(
                                                    '${_hour[index]}.00',
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ))));
                          })),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Jam yang dipilih:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 210,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      4, // number of items in each row
                                  mainAxisSpacing: 8.0, // spacing between rows
                                  crossAxisSpacing:
                                      8.0, // spacing between columns
                                  childAspectRatio: (1 / .5)),
                          padding: const EdgeInsets.all(
                              8.0), // padding around the grid
                          itemCount:
                              _hourSelected.length, // total number of items
                          itemBuilder: (context, index) {
                            _hourSelected.sort();
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    _hourSelected.remove(_hourSelected[index]);
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(34, 158,
                                            158, 158), // color of grid items
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                        child: Text(
                                            '${_hourSelected[index]}.00',
                                            style: const TextStyle(
                                                fontSize: 18)))));
                          })),
                ],
              ),
              InkWell(
                onTap: () async {
                  final mytoken =
                      Provider.of<Token>(context, listen: false).token;
                  final date = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day +
                          Provider.of<SelectedDate>(context, listen: false)
                              .selectedIndex);
                  List<String> myJadwalList = [];
                  for (var e in _hourSelected) {
                    myJadwalList.add(e.toString());
                  }
                  final String myJadwalHour = myJadwalList.join(',');

                  var data = await ApiRepository().postTambahJadwal(
                      token: mytoken,
                      nameVenue: widget.venue.nameVenue ?? '',
                      nameLapangan: widget.lapangan.nameLapangan ?? '',
                      date: date,
                      hour: myJadwalHour,
                      lapanganId: widget.lapangan.id ?? -1);

                  if (data.result != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailLapanganPage(
                                lapangan: widget.lapangan,
                                venue: widget.venue,
                                selectedDateIndex: selectedDateIndex,
                              )),
                    );
                  } else {
                    print(data.error);
                    return;
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  // margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(76, 76, 220, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Atur Jadwal',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
