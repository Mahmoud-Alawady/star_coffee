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
import 'package:star_coffee/presentation/sign_in.dart';
import '../constants/app_strings.dart';
import '../constants/text_styles.dart';
import 'package:star_coffee/presentation/components/no_glow_scroll_behavior.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextStyle style = TextStyles.title.secondary;

  String? email;
  String? password;
  String? name;
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
                          Text(AppStrings.name, style: style),
                          AuthInput(
                              icon: Icons.edit,
                              hint: AppStrings.nameHint,
                              onChanged: (value) => name = value),
                          // Text(AppStrings.phoneNumber, style: style),
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
                          AuthButton(
                              text: AppStrings.signUp, function: _signUp),
                        ],
                      )),
                  const AuthDivider(),
                  const AuthOptions(),
                  GoTo(
                      text1: AppStrings.alreadyHaveAnAccount,
                      text2: AppStrings.signIn,
                      routeBuilder: (context) => const SignIn()),
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

  _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await _createUser();
        _showSnackBar('Account created successfully! please log in');
        if (!context.mounted) return;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const SignIn(),
        ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          _showSnackBar('Email Incorrectly Formatted');
        } else if (e.code == 'email-already-in-use') {
          _showSnackBar(
              'The email address is already in use by another account');
        } else if (e.code == 'weak-password') {
          _showSnackBar('Password should be at least 6 characters');
        } else {
          _showSnackBar(e.toString());
        }
      } catch (e) {
        _showSnackBar(e.toString());
      }
      setState(() {
        isLoading = false;
      });
    } // end if
  }

  Future<void> _createUser() async {
    var result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    result.user?.updateDisplayName(name);
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
