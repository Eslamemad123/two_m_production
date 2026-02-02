
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_m_production/core/GetIt/gi.dart';
import 'package:two_m_production/features/pages/Auth/login/Domain/usecases/login_useCase.dart';
import 'package:two_m_production/features/pages/Auth/login/Presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitState());
  final AuthUseCase authUseCase = gi<AuthUseCase>();
  var keyLogin = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  login() async {
    emit(AuthLoadingState());

    var response = await authUseCase.call(email.text, password.text);
    response.fold(
      (Failure) {
        emit(AuthErrorState(Failure.message));
      },
      (bool) {
        emit(AuthSuccessState());
       
      },
    );
  }
}
