import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_strings.dart';
import 'package:star_coffee/data/cart_item.dart';
import 'package:star_coffee/data/drink.dart';
import 'package:star_coffee/presentation/sign_up.dart';
import 'package:star_coffee/providers/cart_provider.dart';
import 'firebase_options.dart';

void main() async {
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        home: SignUp(),
      ),
    );
  }
}
