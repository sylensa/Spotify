import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify/core/helper/helper.dart';

class AlbumShimmering extends StatelessWidget {
  const AlbumShimmering({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [

          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child:  Container(
               height: appWidth(context) * 0.3,
                decoration: BoxDecoration(
                    color: Colors.grey,

                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(
              height: 15,
              width: appWidth(context) * 0.5,
              color: Colors.grey,

            ),
          ),
          SizedBox(height: 5,),
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(
              height: 15,
              width: appWidth(context) * 0.5,
              color: Colors.grey,

            ),
          ),
          SizedBox(height: 5,),
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(
              height: 15,
              width: appWidth(context) * 0.5,
              color: Colors.grey,

            ),
          ),
        ],
      ),
    );

  }
}