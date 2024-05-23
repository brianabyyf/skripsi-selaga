import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/landing_page.dart';

class MitraProfilePage extends StatelessWidget {
  const MitraProfilePage({super.key});

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
          children: [
            const Center(
              child: CircleAvatar(
                // backgroundColor: Colors.grey,
                radius: 50,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Nama GOR',
              style: TextStyle(color: Color.fromRGBO(76, 76, 220, 1)),
            ),
            const SizedBox(height: 30.0),
            const ListTile(
              title: Text('Penghasilan'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            const ListTile(
              title: Text('Pengaturan'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            const ListTile(
              title: Text('Lapor'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              title: const Text('Keluar'),
              trailing: const Icon(Icons.logout),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
          ],
        ),
      ),
    );
  }
}
