class AuthState {}
class AuthInitState extends AuthState{}

class AuthLoadingState extends AuthState{}

class AuthErrorState extends AuthState{
  final String error;
  AuthErrorState(this.error);
}

class AuthSuccessState extends AuthState{}