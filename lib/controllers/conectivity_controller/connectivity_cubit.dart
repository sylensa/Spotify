// connectivity_bloc.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/controllers/conectivity_controller/connectivity_event.dart';
import 'package:spotify/controllers/conectivity_controller/connectivty_state.dart';


class ConnectivityCubit extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityCubit() : super(ConnectivityInitial()) {
    on<ConnectivityChanged>((event, emit) {
      if (event.isConnected) {
        emit(ConnectivityConnected());
      } else {
        emit(ConnectivityDisconnected());
      }
    });

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
          (ConnectivityResult result) {
        add(ConnectivityChanged(result != ConnectivityResult.none));
      },
    );
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
