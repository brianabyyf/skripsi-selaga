import 'package:flutter/material.dart';
import 'package:selaga_ver1/pages/components/my_box_button.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool box1 = true;
  bool box2 = false;
  bool box3 = false;
  int _currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Pembayaran'),
            centerTitle: true,
            bottom: Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyBoxButton(
                      onTap: () {
                        setState(() {
                          box1 = true;
                          box2 = false;
                          box3 = false;
                          _currentIndexPage = 0;
                        });
                      },
                      buttonText: 'BCA',
                      tapped: box1),
                  MyBoxButton(
                      onTap: () {
                        setState(() {
                          box1 = false;
                          box2 = true;
                          box3 = false;
                          _currentIndexPage = 1;
                        });
                      },
                      buttonText: 'OVO',
                      tapped: box2),
                  MyBoxButton(
                      onTap: () {
                        setState(() {
                          box1 = false;
                          box2 = false;
                          box3 = true;
                          _currentIndexPage = 2;
                        });
                      },
                      buttonText: 'Jago',
                      tapped: box3),
                ],
              ),
            )),
        body: [
          const BcaSection(),
          const OvoSection(),
          const JagoSection(),
        ][_currentIndexPage]);
  }
}

class BcaSection extends StatelessWidget {
  const BcaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(child: Text('BCA')),
      ),
    );
  }
}

class OvoSection extends StatelessWidget {
  const OvoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(child: Text('OVO')),
      ),
    );
  }
}

class JagoSection extends StatelessWidget {
  const JagoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(child: Text('Jago')),
      ),
    );
  }
}
