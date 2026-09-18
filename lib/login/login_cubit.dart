import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepoImpl loginRepoImpl;

  LoginCubit(this.loginRepoImpl) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      await loginRepoImpl.login(body: {'email': email, 'password': password});

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(errMessage: e.toString()));
    }
  }
}
