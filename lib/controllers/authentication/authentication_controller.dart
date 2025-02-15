import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/controllers/authentication/authentication_state.dart';
import 'package:spotify/repository/authentication_repo.dart';


class AuthenticationController extends Cubit<AuthenticationState> {
  final AuthenticationRepo authenticationRepo;
  AuthenticationController(this.authenticationRepo)
      : super(AuthenticationInitial());



  Future<void> getSpotifyToken() async {
    try {
      emit(AuthenticationLoading());
     String? token = await authenticationRepo.getSpotifyToken();
      emit(AuthenticationLoaded(token));
    } catch (_) {
      emit( AuthenticationEmpty());
    }
  }

}
