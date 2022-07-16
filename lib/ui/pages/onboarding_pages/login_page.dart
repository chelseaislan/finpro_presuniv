// @dart=2.9
import 'package:finpro_max/bloc/login/bloc.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:finpro_max/ui/widgets/onboarding_widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final UserRepository _userRepository;

  LoginPage({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary1, appBarColor],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const AppBarSideButton(
          appBarTitle: Text(""),
          appBarColor: Colors.transparent,
        ),
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            userRepository: _userRepository,
          ),
          child: LoginForm(
            userRepository: _userRepository,
          ),
        ),
      ),
    );
  }
}
