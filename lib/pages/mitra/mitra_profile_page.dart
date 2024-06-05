import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/repositories/api_repository.dart';
import 'package:selaga_ver1/repositories/models/user_profile_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class MitraProfilePage extends StatelessWidget {
  const MitraProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: Consumer<Token>(builder: (context, myToken, child) => FutureBuilder(future: ApiRepository().getMyMitraProfile(myToken.token), builder: (context, snapshot) {
    if (snapshot.hasData &&
    snapshot.connectionState == ConnectionState.done) {
    UserProfileMitraModel? profile = snapshot.data?.result;
        return Padding(
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
               Text(
                profile?.name ?? 'no name',
                style: const TextStyle(color: Color.fromRGBO(76, 76, 220, 1)),
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
                onTap: () async {
                  var data = await ApiRepository().mitraLogout(myToken.token);

                  if (data.result != null) {
                    if (!context.mounted) {
                      return;
                    }
                    context.goNamed('landing_page');
                  } else {
                    if (!context.mounted) {
                      return;
                    }
                    SnackBar snackBar = SnackBar(
                      content: Text('${data.error}',
                          style: const TextStyle(fontSize: 16)),
                      // backgroundColor: Colors.indigo,
                      duration: const Duration(milliseconds: 1300),
                      dismissDirection: DismissDirection.up,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(
                          bottom:
                          MediaQuery.of(context).size.height - 150,
                          left: 10,
                          right: 10),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
              const Divider(
                indent: 15,
                endIndent: 15,
              ),
            ],
          ),
        );} else if (snapshot.hasError) {
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
      },),)
    );
  }
}
