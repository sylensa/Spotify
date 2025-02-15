import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify/core/helper/helper.dart';

class ArtistShimmering extends StatelessWidget {
  const ArtistShimmering({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child:  Container(
              padding: appPadding(30),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle
              ),
            ),
          ),
          SizedBox(width: 20,),
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(
              height: 15,
              width: 100,
              color: Colors.grey,

            ),
          )
        ],
      ),
    );

  }
}