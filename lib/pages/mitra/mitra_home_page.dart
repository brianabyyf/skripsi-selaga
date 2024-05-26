import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/mitra/daftar_venue_page.dart';
import 'package:selaga_ver1/pages/mitra/mitra_profile_page.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/endpoints.dart';
import 'package:selaga_ver1/repositories/models/lapangan_model.dart';
import 'package:selaga_ver1/repositories/models/user_profile_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class MitraHomePageNavigation extends StatefulWidget {
  const MitraHomePageNavigation({super.key});

  @override
  State<MitraHomePageNavigation> createState() =>
      _MitraHomePageNavigationState();
}

class _MitraHomePageNavigationState extends State<MitraHomePageNavigation> {
  int _currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const MitraHomePage(),
        const ConfirmationPage(),
        const MemberPage(),
        const MitraProfilePage()
      ][_currentIndexPage],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
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
                text: 'Konfirmasi',
              ),
              GButton(
                icon: Icons.card_membership_sharp,
                text: 'Member',
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

class MitraHomePage extends StatelessWidget {
  const MitraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venue Anda'),
      ),
      body: SafeArea(
        child: Consumer<Token>(
          builder: (context, myToken, child) => FutureBuilder(
            future: Future.wait([
              ApiRepository().getMyProfile(myToken.token),
              ApiRepository().getAllLapangan(myToken.token)
            ]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                UserProfileModel myId = snapshot.data![0].result!;
                List<LapanganModel> venue = snapshot.data![1].result!;
                List<LapanganModel> myVenue =
                    venue.where((e) => e.mitraId == myId.id).toList();
                return myVenue.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: myVenue.length,
                        itemBuilder: (context, index) {
                          var img = myVenue[index].image;
                          var imgList = img?.split(',');
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 16),
                            child: InkWell(
                              onTap: () {},
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: venue[0].image != null
                                            ? Image.network(
                                                '${Endpoints().image}${imgList?.first}',
                                                height: 142,
                                                width: 142,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                width: 142,
                                                height: 142,
                                                decoration: const BoxDecoration(
                                                    color: Colors.grey),
                                                child: const Icon(
                                                    Icons.error_outline),
                                              )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          myVenue[index].name,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
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
                                          myVenue[index].price,
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
                          );
                        },
                      )
                    : const NoVenue();
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 164, 164, 253),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DaftarVenuePage()),
          );
        },
      ),
    );
  }
}

class NoVenue extends StatelessWidget {
  const NoVenue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Anda belum memiliki Venue',
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(width: 2),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DaftarVenuePage()),
              );
            },
            child: const Text(
              'Daftar disini',
              style: TextStyle(
                color: Color.fromRGBO(76, 76, 220, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
