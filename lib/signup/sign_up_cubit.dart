import 'package:doc_doc/signup/sign_up_repo.dart';
import 'package:doc_doc/signup/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignupCubit extends Cubit<SignupState> {
  final SignupRepoImpl signupRepoImpl;

  SignupCubit(this.signupRepoImpl) : super(SignupInitial());

  Future<void> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required int gender,
  }) async {
    emit(SignupLoading());

    try {
      await signupRepoImpl.signup(
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'gender': gender,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure(errMessage: e.toString()));
    }
  }
}
