import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/landing_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    // backgroundColor: Colors.grey,
                    radius: 50,
                  ),
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text("Nama Pengguna"),
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text("Nomor Handphone Pengguna"),
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text("Email Pengguna"),
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                ),
                SizedBox(height: 15.0),
              ],
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LandingPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Keluar"), Icon(Icons.logout)],
                )),
          ],
        ),
      ),
    );
  }
}
