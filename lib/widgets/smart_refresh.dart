import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spotify/widgets/refresh_footer.dart';

class SmartRefresh extends StatefulWidget {
  final Function onRefresh;
  final Function onLoading;
  final Widget child;
  final RefreshController refreshController;
  const SmartRefresh({super.key, required this.onLoading, required this.onRefresh, required this.child,required this.refreshController});

  @override
  State<SmartRefresh> createState() => _SmartRefreshState();
}

class _SmartRefreshState extends State<SmartRefresh> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        reverse: false,
        enablePullDown: true,
        enablePullUp: false,
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus? mode){
          return RefreshFooter(mode: mode,);
          },
        ),
        onLoading:(){
          widget.onLoading();
        },
        onRefresh: (){
          widget.onRefresh();
        },
        controller: widget.refreshController,
        child: widget.child,
      ),
    );
  }
}
