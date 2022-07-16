// @dart=2.9
import 'package:finpro_max/bloc/authentication/bloc.dart';
import 'package:finpro_max/bloc/bloc_delegate.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:finpro_max/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository _userRepository = UserRepository();

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: _userRepository)
        ..add(AppStarted()),
      child: Home(userRepository: _userRepository)));
}
