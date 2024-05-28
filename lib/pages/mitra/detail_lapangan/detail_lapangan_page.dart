import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/mitra/detail_lapangan/atur_jadwal.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/lapangan_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class DetailLapanganPage extends StatelessWidget {
  final int idLapangan;
  final String namaLapangan;
  const DetailLapanganPage(
      {super.key, required this.idLapangan, required this.namaLapangan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal $namaLapangan'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Consumer<Token>(
        builder: (context, value, child) => FutureBuilder(
          future: ApiRepository().getJadwalLapangan(value.token),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              List<JadwalLapanganModel> jadwal = snapshot.data?.result ?? [];
              List<JadwalLapanganModel> myJadwal =
                  jadwal.where((e) => e.lapanganId == idLapangan).toList();
              return MyJadwal(myJadwal: myJadwal);
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
      )),
    );
  }
}

class MyJadwal extends StatefulWidget {
  const MyJadwal({
    super.key,
    required this.myJadwal,
  });

  final List<JadwalLapanganModel> myJadwal;

  @override
  State<MyJadwal> createState() => _MyJadwalState();
}

class _MyJadwalState extends State<MyJadwal> {
  int _selectedGridIndex = -1;
  List<String> hour = [];
  List<String> availableHour = [];
  List<String> unAvailableHour = [];
  List<int> hourSorted = [];
  List<int> availableHourSorted = [];
  List<int> unAvailableHourSorted = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    for (var e in widget.myJadwal) {
      if (e.days ==
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
        availableHour = e.availableHour!.split(',').toList();
      }
    }
    for (var e in availableHour) {
      hour.add(e);
      availableHourSorted.add(int.parse(e));
    }

    for (var e in widget.myJadwal) {
      if (e.days ==
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
        unAvailableHour = e.unavailableHour!.split(',').toList();
      }
    }
    for (var e in unAvailableHour) {
      hour.add(e);
      unAvailableHourSorted.add(int.parse(e));
    }

    for (var e in hour) {
      hourSorted.add(int.parse(e));
    }
    hourSorted.sort();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(19, 76, 76, 220)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                        '${DateFormat('MMMM').format(DateTime.now())} ${DateTime.now().year}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 80,
                      width: 222,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    Provider.of<SelectedDate>(context,
                                            listen: false)
                                        .getSelectedIndex(index);

                                    _selectedIndex = Provider.of<SelectedDate>(
                                            context,
                                            listen: false)
                                        .selectedIndex;

                                    hour.clear();
                                    hourSorted.clear();
                                    availableHourSorted.clear();
                                    unAvailableHourSorted.clear();

                                    for (var e in widget.myJadwal) {
                                      if (e.days ==
                                          DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day + index)) {
                                        availableHour = e.availableHour!
                                            .split(',')
                                            .toList();
                                      }
                                    }
                                    for (var e in availableHour) {
                                      hour.add(e);
                                      availableHourSorted.add(int.parse(e));
                                    }

                                    for (var e in widget.myJadwal) {
                                      if (e.days ==
                                          DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day + index)) {
                                        unAvailableHour = e.unavailableHour!
                                            .split(',')
                                            .toList();
                                      }
                                    }
                                    for (var e in unAvailableHour) {
                                      hour.add(e);
                                      unAvailableHourSorted.add(int.parse(e));
                                    }

                                    for (var e in hour) {
                                      hourSorted.add(int.parse(e));
                                    }
                                    hourSorted.sort();
                                  });
                                },
                                child: Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Provider.of<SelectedDate>(context,
                                                      listen: true)
                                                  .selectedIndex ==
                                              index
                                          ? const Color.fromRGBO(76, 76, 220, 1)
                                          : const Color.fromARGB(
                                              61, 76, 76, 220),
                                    ),
                                    child: index == 0
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${DateTime.now().day}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  DateFormat('EEE')
                                                      .format(DateTime.now()),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          )
                                        : index == 1
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${DateTime.now().day + 1}',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      DateFormat('EEE').format(
                                                          DateTime(
                                                              DateTime.now()
                                                                  .year,
                                                              DateTime.now()
                                                                  .month,
                                                              DateTime.now()
                                                                      .day +
                                                                  1)),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${DateTime.now().day + 2}',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      DateFormat('EEE').format(
                                                          DateTime(
                                                              DateTime.now()
                                                                  .year,
                                                              DateTime.now()
                                                                  .month,
                                                              DateTime.now()
                                                                      .day +
                                                                  2)),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ))),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Selected Date'),
                    Text(
                      DateFormat('dd MMMM yyyy').format(DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day +
                              Provider.of<SelectedDate>(context, listen: false)
                                  .selectedIndex)),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jam',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        'harga',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(' /Jam'),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Expanded(
            child: widget.myJadwal.any((e) =>
                    e.days ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day + _selectedIndex))
                ? SizedBox(
                    height: 170,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // number of items in each row
                              mainAxisSpacing: 8.0, // spacing between rows
                              crossAxisSpacing: 8.0, // spacing between columns
                              childAspectRatio: (1 / .5)),
                      padding:
                          const EdgeInsets.all(8.0), // padding around the grid
                      itemCount: hourSorted.length, // total number of items
                      itemBuilder: (context, index) {
                        bool tapped = index == _selectedGridIndex;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedGridIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: tapped
                                    ? Colors.blue
                                    : unAvailableHourSorted
                                            .contains(hourSorted[index])
                                        ? Colors.red
                                        : const Color.fromARGB(34, 158, 158,
                                            158), // color of grid items
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                                child: Text('${hourSorted[index]}.00',
                                    style: unAvailableHourSorted
                                            .contains(hourSorted[index])
                                        ? const TextStyle(
                                            fontSize: 18.0, color: Colors.white)
                                        : const TextStyle(fontSize: 18.0))),
                          ),
                        );
                      },
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: Text('Jadwal Tidak Tersedia')),
                      TextButton(
                        onPressed: () {
                          print('object');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AturJadwalPage()),
                          );
                        },
                        child: const Text(
                          'Atur Jadwal',
                          style: TextStyle(
                            color: Color.fromRGBO(76, 76, 220, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
          ),
          widget.myJadwal.any((e) =>
                  e.days ==
                  DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day +
                          Provider.of<SelectedDate>(context, listen: false)
                              .selectedIndex))
              ? InkWell(
                  onTap: () {
                    // final mytoken = Provider.of<Token>(context, listen: false).token;

                    // var data = await ApiRepository().daftarLapangan(
                    //     mytoken,
                    //     'Lapangan ${myLapangan.length + 1}',
                    //     myLapangan.first.venueId!);

                    // if (data.result != null) {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => MyLapanganPage(
                    //               venueId: myLapangan.first.venueId!,
                    //             )),
                    //   );
                    // }
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
                        'Terapkan Jadwal',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
