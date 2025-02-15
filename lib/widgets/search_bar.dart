import 'package:flutter/material.dart';
import 'package:spotify/core/helper/helper.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController searchController;

  const SearchBarWidget({super.key, required this.onChanged, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search artists or albums...",
          hintStyle: appStyle(col: Colors.black),
          prefixIcon: Icon(Icons.search,color: Colors.black,),
          focusColor: Colors.grey,
          focusedBorder:OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ) ,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
        ),
        onChanged: onChanged,  // Call API on input change
      ),
    );
  }
}
