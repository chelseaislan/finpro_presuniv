// @dart=2.9
import 'package:finpro_max/bloc/authentication/authentication_bloc.dart';
import 'package:finpro_max/bloc/authentication/authentication_state.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:finpro_max/ui/pages/onboarding_pages/complete_profile_page.dart';
import 'package:finpro_max/ui/pages/onboarding_pages/login_page.dart';
import 'package:finpro_max/ui/pages/onboarding_pages/splash.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  final UserRepository _userRepository;

  Home({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "TTCommons"),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      // the auth bloc covers all the widget tree
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is InitialState) {
            return Splash();
          }
          if (state is Authenticated) {
            return HomeTabs(
              userId: state.userId,
              selectedPage: 0,
            );
          }
          if (state is AuthenticatedButNotSet) {
            return CompleteProfilePage(
              userRepository: _userRepository,
              userId: state.userId,
            );
          }
          if (state is Unauthenticated) {
            return LoginPage(
              userRepository: _userRepository,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
