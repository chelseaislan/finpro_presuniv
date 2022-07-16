// @dart=2.9
import 'package:finpro_max/bloc/authentication/authentication_bloc.dart';
import 'package:finpro_max/bloc/authentication/authentication_event.dart';
import 'package:finpro_max/bloc/signup/bloc.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/text_radio_field.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpForm extends StatefulWidget {
  final UserRepository _userRepository;

  SignUpForm({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignUpBloc _signUpBloc;
  //UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      !_emailController.text.contains("@mm.id") &&
      _passwordController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state) {
    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    super.initState();
  }

  void _onFormSubmitted() {
    _signUpBloc.add(
      SignUpWithCredentialsPressed(
          email: _emailController.text, password: _passwordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (BuildContext context, SignUpState state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackbar(
              text: "Sign up failed, please try again. (404)",
              duration: 3,
              background: primary2,
            ),
          );
        }
        if (state.isSubmitting) {
          debugPrint("isSubmitting");
          ScaffoldMessenger.of(context).showSnackBar(
            myLoadingSnackbar(
              text: "Creating account...",
              duration: 3,
              background: primaryBlack,
            ),
          );
        }
        if (state.isSuccess) {
          debugPrint("Success!");
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackbar(
              text: "Sign up successful!",
              duration: 3,
              background: primaryBlack,
            ),
          );
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          // Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/logo_login.png",
                      width: size.width * 0.7,
                      height: size.width * 0.7,
                    ),
                  ),
                  HeaderTwoText(
                    text: "Hello there!",
                    color: white,
                    align: TextAlign.left,
                  ),
                  const SizedBox(height: 15),
                  DescText(
                    text:
                        "“Live in the present, make the most of it, it's all you've got.” - June Osborne",
                    color: white,
                    align: TextAlign.left,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
                    child: Divider(
                      color: white,
                      height: 1,
                      thickness: 0.2,
                    ),
                  ),
                  LoginTextFieldWidget(
                    textCapitalization: TextCapitalization.none,
                    textAction: TextInputAction.next,
                    text: "Email Address",
                    controller: _emailController,
                    color: white,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email_outlined),
                    textInputType: TextInputType.emailAddress,
                    textValidator: (_) {
                      return !state.isEmailValid ? "Invalid Email" : null;
                    },
                    maxLines: 1,
                  ),
                  LoginTextFieldWidget(
                    textCapitalization: TextCapitalization.none,
                    textAction: TextInputAction.done,
                    text: "Password",
                    controller: _passwordController,
                    color: white,
                    obscureText: true,
                    prefixIcon: const Icon(Icons.vpn_key_outlined),
                    textInputType: TextInputType.visiblePassword,
                    textValidator: (_) {
                      return !state.isPasswordValid
                          ? "Password must be at least 6 characters with a number."
                          : null;
                    },
                    maxLines: 1,
                  ),
                  Divider(
                    color: white,
                    height: 1,
                    thickness: 0.2,
                  ),
                  const SizedBox(height: 15),
                  SmallText(
                    text:
                        "By signing up, you agree to our Terms of Use and Privacy Policy.",
                    color: white,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: size.width,
                    child: BigWideButton(
                      labelText: "Create Account",
                      onPressedTo: isSignUpButtonEnabled(state)
                          ? _onFormSubmitted
                          : null,
                      textColor:
                          isSignUpButtonEnabled(state) ? secondBlack : white,
                      btnColor: isSignUpButtonEnabled(state)
                          ? Colors.amber
                          : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChanged() {
    _signUpBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();

    super.dispose();
  }
}
