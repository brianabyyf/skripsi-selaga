import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/mitra/homepage/component/have_venue.dart';
import 'package:selaga_ver1/pages/mitra/homepage/component/no_venue.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/user_profile_model.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

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
              ApiRepository().getAllVenue(myToken.token)
            ]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                UserProfileModel myId = snapshot.data![0].result!;
                List<VenueModel> venue = snapshot.data![1].result!;
                List<VenueModel> myVenue =
                    venue.where((e) => e.mitraId == myId.id).toList();
                return myVenue.isNotEmpty
                    ? HaveVenue(myVenue: myVenue)
                    : const NoVenue();
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
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
    );
  }
}
