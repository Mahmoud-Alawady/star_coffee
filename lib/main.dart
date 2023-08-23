import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:star_coffee/bussiness/stripe_payment/stripe_keys.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_strings.dart';
import 'package:star_coffee/constants/globals.dart';
import 'package:star_coffee/data/cart_item.dart';
import 'package:star_coffee/data/drink.dart';
import 'package:star_coffee/presentation/sign_up.dart';
import 'package:star_coffee/providers/cart_provider.dart';
import 'firebase_options.dart';

void main() async {
  Stripe.publishableKey = ApiKeys.publishableKey;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Hive init
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(DrinkAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: AppColors.secondary,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: AppColors.background,
      statusBarIconBrightness: Brightness.dark,
    ));

    Globals.setScreenSize(MediaQuery.of(context).size);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        theme: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          outline: AppColors.primary,
        )),
        home: const SignUp(),
      ),
    );
  }
}
