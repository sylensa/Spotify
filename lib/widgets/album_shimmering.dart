import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AlbumShimmering extends StatelessWidget {
  const AlbumShimmering({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child:  Container(
             height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(
              height: 15,
              width: 100,
              color: Colors.grey,

            ),
          ),
          SizedBox(height: 5,),
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(
              height: 15,
              width: 100,
              color: Colors.grey,

            ),
          ),
          SizedBox(height: 5,),
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(
              height: 15,
              width: 100,
              color: Colors.grey,

            ),
          ),
        ],
      ),
    );

  }
}