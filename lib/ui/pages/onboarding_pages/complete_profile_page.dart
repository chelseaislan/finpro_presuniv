// @dart=2.9
import 'package:finpro_max/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:finpro_max/ui/widgets/onboarding_widgets/complete_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfilePage extends StatelessWidget {
  final _userRepository;
  final userId;

  CompleteProfilePage({@required UserRepository userRepository, String userId})
      : assert(userRepository != null && userId != null),
        _userRepository = userRepository,
        userId = userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Complete Your Profile",
          color: pureWhite,
        ),
        appBarColor: primary1,
      ),
      body: BlocProvider<CompleteProfileBloc>(
        create: (context) =>
            CompleteProfileBloc(userRepository: _userRepository),
        child: CompleteProfileForm(userRepository: _userRepository),
      ),
    );
  }
}
