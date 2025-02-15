

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
class AuthenticationEmpty extends AuthenticationState {}

class AuthenticationLoaded extends AuthenticationState {
  final String? token;
  AuthenticationLoaded(this.token);
}




