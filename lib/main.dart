import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_strings.dart';
import 'package:star_coffee/presentation/sign_up.dart';
import 'package:star_coffee/providers/cart_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        // theme: ThemeData(
        //   primaryColor: AppColors.primary,
        // ),
        // theme: ThemeData(
        //   brightness: Brightness.dark,
        //   colorScheme: const ColorScheme(
        //     brightness: Brightness.dark,
        //     primary: Color(0xffD84315),
        //     onPrimary: Colors.black,
        //     secondary: Color(0xff411530),
        //     onSecondary: Colors.white,
        //     error: Colors.red,
        //     onError: Colors.white,
        //     background: Color(0xffFFCDD2),
        //     onBackground: Colors.black,
        //     surface: Color(0xffFFCDD2),
        //     onSurface: Color(0xffE3A649),
        //   ),
        //   // Define the default font family.
        //   fontFamily: 'Georgia',
        //   // Define the default `TextTheme`. Use this to specify the default
        //   // text styling for headlines, titles, bodies of text, and more.
        //   textTheme: const TextTheme(
        //     displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
        //     titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
        //     bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
        //   ),
        // ),
        home: SignUp(),
      ),
    );
  }
}
