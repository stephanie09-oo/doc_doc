import 'package:doc_doc/login/login.dart';
import 'package:doc_doc/login/login_cubit.dart';
import 'package:doc_doc/login/login_repo.dart';
import 'package:doc_doc/routes/routes.dart';
import 'package:doc_doc/signup/signup.dart';
import 'package:doc_doc/signup/sign_up_cubit.dart';
import 'package:doc_doc/signup/sign_up_repo.dart';
import 'package:doc_doc/view/OnboardingView.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../Home/Homeview.dart';

class AppRouter {
  static final GoRouter router = GoRouter(routes: route);

  static final List<GoRoute> route = [
    GoRoute(
      path: Routes.onboardingview,
      builder: (context, state) => Onboardingview(),
    ),
    GoRoute(
      path: Routes.signup,
      builder: (context, state) {
        return BlocProvider<SignupCubit>(
          create: (context) => SignupCubit(SignupRepoImpl()),
          child:  Signupview(),
        );
      },
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(LoginRepoImpl()),
          child: Loginview(),
        );
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => HomeView(),
    ),
  ];
}
