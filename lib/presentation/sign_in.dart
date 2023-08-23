import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/constants/globals.dart';
import 'package:star_coffee/presentation/components/auth_button.dart';
import 'package:star_coffee/presentation/components/auth_divider.dart';
import 'package:star_coffee/presentation/components/auth_input.dart';
import 'package:star_coffee/presentation/components/auth_options.dart';
import 'package:star_coffee/presentation/components/goto.dart';
import 'package:star_coffee/presentation/sign_up.dart';
import '../constants/app_strings.dart';
import '../constants/text_styles.dart';
import 'home_screen.dart';
import 'package:star_coffee/presentation/components/no_glow_scroll_behavior.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextStyle style = TextStyles.title.secondary;

  String? email;
  String? password;
  String? phoneNumber;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Globals.horizontalPadding),
            child: ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  _buildWelcome(),
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.email, style: style),
                          AuthInput(
                              icon: Icons.email,
                              hint: AppStrings.emailHint,
                              onChanged: (value) => email = value),
                          Text(AppStrings.password, style: style),
                          AuthInput(
                              icon: Icons.lock,
                              hint: AppStrings.passwordHint,
                              onChanged: (value) => password = value),
                          const SizedBox(height: 12),
                          AuthButton(text: AppStrings.logIn, function: signIn),
                        ],
                      )),
                  const AuthDivider(),
                  const AuthOptions(),
                  GoTo(
                      text1: AppStrings.dontHaveAccount,
                      text2: AppStrings.signUp,
                      routeBuilder: (context) => const SignUp()),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildWelcome() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(children: [
        Text(AppStrings.welcome, style: TextStyles.titleXL.secondary),
        const SizedBox(width: 12),
        SvgPicture.asset(AppPaths.welcomeIcon),
      ]),
    );
  }

  signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await login();
        showSnackBar('Logged in!');
        if (!context.mounted) return;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          showSnackBar('Email Incorrectly Formatted');
        } else if (e.code == 'user-not-found') {
          showSnackBar('Email Address not Found');
        } else if (e.code == 'wrong-password') {
          showSnackBar('Wrong Password');
        } else {
          showSnackBar(e.code.toString());
        }
      } catch (e) {
        showSnackBar(e.toString());
      }
      setState(() {
        isLoading = false;
      });
    } // end if
  }

  Future<void> login() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
