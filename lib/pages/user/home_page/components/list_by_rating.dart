import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:selaga_ver1/pages/components/sportfieldcard.dart';
import 'package:selaga_ver1/repositories/models/endpoints.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';
import 'package:selaga_ver1/repositories/providers.dart';

class VenueByRating extends StatelessWidget {
  const VenueByRating({
    super.key,
    required this.venue,
  });

  final List<VenueModel> venue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 327,
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
              fieldName: venue[index].nameVenue ?? '',
              fieldImage: imgList != null
                  ? '${Endpoints().image}${imgList.first}'
                  : null,
              fieldLocation: venue[index].lokasiVenue ?? '',
              fieldPrice: venue[index].price ?? '',
              onPressed: () {
                context.read<UserId>().getUserId(venue[index].id ?? 0);
                context.pushNamed('user_detail_venue');
              },
              fieldRating: venue[index].rating ?? '0',
            ),
          );
        },
      ),
    );
  }
}
