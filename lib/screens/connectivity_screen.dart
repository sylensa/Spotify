import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/controllers/conectivity_controller/connectivity_cubit.dart';
import 'package:spotify/controllers/conectivity_controller/connectivty_state.dart';
import 'package:spotify/core/helper/helper.dart';

class ConnectivityScreen extends StatelessWidget {
  final Widget child;
  const ConnectivityScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit,ConnectivityState>(builder: (context,state){
     return Stack(
        children: [
         child,
          if(state is ConnectivityDisconnected)
          Positioned(
              bottom:20,
              width: appWidth(context),
              child: noInternetConnection()
          )

        ],
      );
    });
  }
}
