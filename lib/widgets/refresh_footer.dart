import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshFooter extends StatelessWidget {
 final LoadStatus? mode;
  const RefreshFooter({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      Widget body ;
      if(mode==LoadStatus.idle){
        body =  const Text("No more Data");
      }
      else if(mode==LoadStatus.loading){
        body =  const CupertinoActivityIndicator();
      }
      else if(mode == LoadStatus.failed){
        body = const Text("Load Failed!Click retry!");
      }
      else if(mode == LoadStatus.canLoading){
        body = const Text("release to load more");
      }
      else{
        body = const Text("No more Data");
      }
      return Container(
        height: 55.0,
        child: Center(child:body),
      );
    });
  }
}
