import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testable_web_app/login/authentication/authentication.dart';
import 'package:testable_web_app/login/widgets/login_view_widget.dart';
import 'package:user_repository/user_repository.dart';

class LoginAppLandingScreen extends StatelessWidget {
  LoginAppLandingScreen({
    Key? key,
    // required this.authenticationRepository,
    // required this.userRepository,
  }) : super(key: key);

  // Temp fix
  // ignore: avoid_field_initializers_in_const_classes
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  // ignore: avoid_field_initializers_in_const_classes
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: const LoginView(),
      ),
    );
  }
}
