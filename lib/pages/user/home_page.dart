import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:selaga_ver1/pages/user/profile_page.dart';
import 'package:selaga_ver1/pages/user/riwayat_page.dart';

class HomePageNavigation extends StatefulWidget {
  const HomePageNavigation({super.key});

  @override
  State<HomePageNavigation> createState() => _HomePageNavigationState();
}

class _HomePageNavigationState extends State<HomePageNavigation> {
  int _currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomePage(),
        const RiwayatPage(),
        const ProfilePage()
      ][_currentIndexPage],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: GNav(
            // rippleColor: const Color.fromRGBO(76, 76, 220, 0.5),
            // hoverColor: const Color.fromRGBO(76, 76, 220, 0.5),
            gap: 8,
            color: Colors.grey,
            activeColor: const Color.fromRGBO(76, 76, 220, 1),
            tabBackgroundColor: const Color.fromRGBO(76, 76, 220, 0.25),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            iconSize: 24,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Beranda',
              ),
              GButton(
                icon: Icons.view_list_rounded,
                text: 'Riwayat',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              )
            ],
            selectedIndex: _currentIndexPage,
            onTabChange: (index) {
              setState(() {
                _currentIndexPage = index;
              });
            },
          ),
        )),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selaga'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tempat populer',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              SportsFieldCard(
                fieldName: 'Tempat A',
                fieldImage: 'assets/field_a.jpg',
                fieldLocation: 'Lokasi A',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const FieldDetailPage(fieldName: 'Tempat A')),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              SportsFieldCard(
                fieldName: 'Tempat B',
                fieldImage: 'assets/field_b.jpg',
                fieldLocation: 'Lokasi B',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const FieldDetailPage(fieldName: 'Tempat B')),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              SportsFieldCard(
                fieldName: 'Tempat C',
                fieldImage: 'assets/field_b.jpg',
                fieldLocation: 'Lokasi C',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const FieldDetailPage(fieldName: 'Tempat B')),
                  );
                },
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

class SportsFieldCard extends StatelessWidget {
  final String fieldName;
  final String fieldImage;
  final String fieldLocation;
  final VoidCallback onPressed;

  const SportsFieldCard({
    super.key,
    required this.fieldName,
    required this.fieldImage,
    required this.fieldLocation,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 300.0,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                fieldImage,
                width: 300.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              fieldName,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              fieldLocation,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FieldDetailPage extends StatelessWidget {
  final String fieldName;

  const FieldDetailPage({super.key, required this.fieldName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              // width: 300,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(8)),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: Row(
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
            SizedBox(
              height: 10,
            ),
            Text('Nama Tempat'),
            Text('harga /jam'),
            Text('lokasi'),

            SizedBox(
              height: 10,
            ),

            Text('Preview'),

            SizedBox(
              height: 105,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 105,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  );
                },
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
                    child: Text(
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
    );
  }
}

class TimeSlotItem extends StatelessWidget {
  final String time;
  final VoidCallback onPressed;

  const TimeSlotItem({super.key, required this.time, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blue,
        ),
        child: Text(
          time,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
