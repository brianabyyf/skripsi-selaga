import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:selaga_ver1/pages/components/sportfieldcard.dart';
import 'package:selaga_ver1/pages/user/detail_page.dart';
import 'package:selaga_ver1/pages/user/profile_page.dart';
import 'package:selaga_ver1/pages/user/riwayat_page.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/lapangan_model.dart';

class HomePageNavigation extends StatefulWidget {
  final String token;
  const HomePageNavigation({super.key, required this.token});

  @override
  State<HomePageNavigation> createState() => _HomePageNavigationState();
}

class _HomePageNavigationState extends State<HomePageNavigation> {
  int _currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomePage(
          token: widget.token,
        ),
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

class HomePage extends StatefulWidget {
  final String token;
  const HomePage({super.key, required this.token});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: ApiRepository().getAllLapangan(widget.token),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<LapanganModel> venue = snapshot.data!.result!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBarTheme(
                    data: SearchBarThemeData(
                        surfaceTintColor:
                            MaterialStatePropertyAll(Colors.grey)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: SearchBar(
                        leading: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Berdasarkan Rating',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Lihat semua',
                            style: TextStyle(
                              color: Color.fromRGBO(76, 76, 220, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: venue.length,
                      itemBuilder: (context, index) {
                        var img = venue[index].image;
                        var imgList = img?.split(',');
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SportsFieldCard(
                            fieldName: venue[index].name,
                            fieldImage: imgList != null
                                ? 'http://192.168.0.106/skripsi-selaga/storage/app/image/${imgList.first}'
                                : null,
                            fieldLocation: venue[index].address,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FieldDetailPage(
                                          token: widget.token,
                                          id: venue[index].id,
                                        )),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tempat populer',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Lihat semua',
                            style: TextStyle(
                              color: Color.fromRGBO(76, 76, 220, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FieldDetailPage(
                                    token: widget.token, id: venue[0].id)));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: venue[0].image != null
                                    ? Image.network(
                                        'http://192.168.0.106/skripsi-selaga/storage/app/image/${venue[0].image}',
                                        height: 142,
                                        width: 142,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: 142,
                                        height: 142,
                                        decoration: const BoxDecoration(
                                            color: Colors.grey),
                                        child: const Icon(Icons.error_outline),
                                      )),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  venue[0].name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // maxLines: 1,
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  venue[0].address,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                  // maxLines: 1,
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  venue[0].price,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                  // maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
      )),
    );
  }
}
