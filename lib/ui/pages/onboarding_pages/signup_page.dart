// @dart=2.9
import 'package:finpro_max/bloc/signup/bloc.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:finpro_max/ui/widgets/onboarding_widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  final UserRepository _userRepository;

  SignUpPage({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appBarColor, primary1],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const AppBarSideButton(
          appBarTitle: Text("Create account"),
          appBarColor: Colors.transparent,
        ),
        body: BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(
            userRepository: _userRepository,
          ),
          child: SignUpForm(
            userRepository: _userRepository,
          ),
        ),
      ),
    );
  }
}
