import 'package:flutter/material.dart';

class MyUploadVenueButton extends StatelessWidget {
  final Function()? onTap;
  const MyUploadVenueButton({
    super.key,
    required bool isSending,
    this.onTap,
  }) : _isSending = isSending;

  final bool _isSending;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // onTap: _isSending ? null : _uploadVenue,
      // onTap: () {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => SuccesssDaftarVenuePage(
      //               token: widget.token,
      //             )),
      //   );
      // },
      child: Container(
        padding: const EdgeInsets.all(20),
        // margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(76, 76, 220, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: _isSending
              ? const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const Text(
                  'Daftar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
