// import 'package:flutter/material.dart';
// import 'package:selaga_ver1/pages/landing_page.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: CircleAvatar(
//                     // backgroundColor: Colors.grey,
//                     radius: 50,
//                   ),
//                 ),
//                 SizedBox(height: 30.0),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20, bottom: 10),
//                   child: Text("Nama Pengguna"),
//                 ),
//                 Divider(
//                   indent: 15,
//                   endIndent: 15,
//                 ),
//                 SizedBox(height: 15.0),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20, bottom: 10),
//                   child: Text("Nomor Handphone Pengguna"),
//                 ),
//                 Divider(
//                   indent: 15,
//                   endIndent: 15,
//                 ),
//                 SizedBox(height: 15.0),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20, bottom: 10),
//                   child: Text("Email Pengguna"),
//                 ),
//                 Divider(
//                   indent: 15,
//                   endIndent: 15,
//                 ),
//                 SizedBox(height: 15.0),
//               ],
//             ),
//             TextButton(
//                 onPressed: () {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const LandingPage()),
//                     (Route<dynamic> route) => false,
//                   );
//                 },
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [Text("Keluar"), Icon(Icons.logout)],
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/landing_page.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/user_profile_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: Consumer<Token>(
        builder: (context, myToken, child) => FutureBuilder(
          future: ApiRepository().getMyProfile(myToken.token),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              UserProfileModel? profile = snapshot.data?.result;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: CircleAvatar(
                            // backgroundColor: Colors.grey,
                            radius: 50,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        ListTile(
                          title: const Text('Nama'),
                          subtitle: Text("${profile?.name}"),
                        ),
                        const Divider(
                          indent: 15,
                          endIndent: 15,
                        ),
                        ListTile(
                          title: const Text('Telepon'),
                          subtitle: Text("${profile?.phone}"),
                        ),
                        const Divider(
                          indent: 15,
                          endIndent: 15,
                        ),
                        ListTile(
                          title: const Text('Email'),
                          subtitle: Text("${profile?.email}"),
                        ),
                        const Divider(
                          indent: 15,
                          endIndent: 15,
                        ),
                        ListTile(
                          onTap: () {
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const LandingPage()),
                            //   (Route<dynamic> route) => false,
                            // );
                            context.goNamed('landing_page');
                          },
                          title: const Text('Keluar'),
                          trailing: const Icon(Icons.logout),
                        ),
                        const Divider(
                          indent: 15,
                          endIndent: 15,
                        ),
                        const SizedBox(height: 15.0),
                      ],
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       Navigator.pushAndRemoveUntil(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const LandingPage()),
                    //         (Route<dynamic> route) => false,
                    //       );
                    //     },
                    //     child: const Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [Text("Keluar"), Icon(Icons.logout)],
                    //     )),
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
        ),
      ),
    );
  }
}
