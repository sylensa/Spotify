import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify/core/helper/helper.dart';

class ArtistShimmering extends StatelessWidget {
  const ArtistShimmering({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child:  Container(
          padding: appPadding(20),
          decoration: BoxDecoration(
            color: Colors.grey,
              shape: BoxShape.circle
          ),
        ),
      ),
      title: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Container(
          height: 15,
          width: 100,
          color: Colors.grey,

        ),
      ),
    );

  }
}