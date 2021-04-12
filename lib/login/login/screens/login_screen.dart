import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:testable_web_app/login/login/bloc/login_bloc.dart';
import 'package:testable_web_app/login/widgets/login_form_widget.dart';

class LoginLoginScreen extends StatelessWidget {
  const LoginLoginScreen({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginLoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
