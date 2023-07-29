import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/constants/app_styles.dart';
import 'package:star_coffee/presentation/components/no_glow_scroll_behavior.dart';
import '../constants/app_strings.dart';
import 'home_page.dart';
import 'package:star_coffee/constants/globals.dart' as globals;

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  // final _formItemKey = GlobalKey();
  // double? _txtHeight; 48

  late BuildContext context;
  String? email;
  String? password;
  String? name;
  String? phoneNumber;

  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    globals.setScreenSize(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: globals.horizontalPadding),
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                _buildWelcome(),
                _buildForm(),
                _buildDivider(),
                _buildLoginOptions(),
                _buildGoToSignIn(),
              ]),
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
        Text(AppStrings.welcome, style: AppStyles.getTextStyle()),
        const SizedBox(width: 12),
        SvgPicture.asset(AppPaths.welcomeIcon),
      ]),
    );
  }

  _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.name, style: AppStyles.getTextStyle()),
            _buildTextField(
                Icons.edit, AppStrings.nameHint, (value) => name = value),
            Text(AppStrings.phoneNumber, style: AppStyles.getTextStyle()),
            _buildTextField(Icons.phone, AppStrings.phoneNumberHint,
                (value) => phoneNumber = value),
            Text(AppStrings.email, style: AppStyles.getTextStyle()),
            _buildTextField(
                Icons.email, AppStrings.emailHint, (value) => email = value),
            Text(AppStrings.password, style: AppStyles.getTextStyle()),
            _buildTextField(Icons.lock, AppStrings.passwordHint,
                (value) => password = value),
            const SizedBox(height: 12),
            _buildSignUp(),
          ],
        ));
  }

  _buildTextField(
    IconData icon,
    String hint,
    void Function(String)? onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          prefixIcon: Icon(icon),
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        ),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'this field is required!';
          }
          return null;
        },
      ),
    );
  }

  _buildSignUp() {
    double height = 48;
    double padding = 6;
    double arrowSize = height - 2 * padding;
    return MaterialButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email!, password: password!);
          }
        },
        color: AppColors.primary,
        elevation: 0,
        padding: EdgeInsets.all(padding),
        minWidth: double.infinity,
        height: height,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                AppStrings.signUp,
                style: AppStyles.getTextStyle(
                    16, Colors.white, AppStrings.interFont, FontWeight.w900),
              ),
            ),
            Container(
              width: arrowSize,
              height: arrowSize,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ));

    // MaterialButton(
    //   onPressed: () {
    //     if (_formKey.currentState!.validate()) {
    //       FirebaseAuth.instance.createUserWithEmailAndPassword(
    //           email: email!, password: password!);
    //     }
    //   },
    //   color: AppColors.primary,
    //   elevation: 0,
    //   minWidth: double.infinity,
    //   height: 44,
    //   shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(10))),
    //   child: Text(
    //     AppStrings.signUp,
    //     style: AppStyles.getTextStyle(
    //         16, Colors.white, AppStrings.interFont, FontWeight.w900),
    //   ),
    // );
  }

  // _buildSignUpWithGoogle() {
  //   return MaterialButton(
  //     onPressed: () {},
  //     color: AppColors.grey,
  //     elevation: 0,
  //     minWidth: double.infinity,
  //     height: 44,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(30))),
  //     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //       SizedBox.square(
  //         dimension: 24,
  //         child: SvgPicture.asset(AppPaths.googleIcon),
  //       ),
  //       const SizedBox(width: 10),
  //       Text(
  //         AppStrings.signUpWithGoogle,
  //         style: AppStyles.getTextStyle(
  //             16, Colors.black, AppStrings.interFont, FontWeight.w900),
  //       ),
  //     ]),
  //   );
  // }

  _buildGoToSignIn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
        },
        child: RichText(
          text: TextSpan(
            text: AppStrings.alreadyHaveAnAccount,
            style:
                AppStyles.getTextStyle(14, Colors.grey, AppStrings.interFont),
            children: [
              TextSpan(
                text: AppStrings.signIn,
                style:
                    AppStyles.getTextStyle(14, Colors.red, AppStrings.interFont)
                        .copyWith(decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Expanded(child: Divider(endIndent: 12)),
          Text(AppStrings.orContinueWith,
              style: AppStyles.getTextStyle(
                  12, AppColors.secondary, AppStrings.poppinsFont)),
          const Expanded(child: Divider(indent: 12)),
        ],
      ),
    );
  }

  _buildLoginOptions() {
    const space = SizedBox(width: 6);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBox(AppPaths.googleIcon, () {}),
        space,
        _buildBox(AppPaths.facebookIcon, () {}),
        space,
        _buildBox(AppPaths.twitterIcon, () {}),
      ],
    );
  }

  _buildBox(String icon, VoidCallback function) {
    const borderRadius = BorderRadius.all(Radius.circular(8));
    final decoration = BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: AppColors.secondary,
        ));

    return Expanded(
      child: InkWell(
        onTap: function,
        borderRadius: borderRadius,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: decoration,
          child: SizedBox(height: 34, width: 34, child: SvgPicture.asset(icon)),
        ),
      ),
    );
  }
}
