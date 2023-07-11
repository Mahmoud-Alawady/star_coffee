import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_strings.dart';
import 'package:star_coffee/presentation/home_screen.dart';
import 'package:star_coffee/providers/cart_items_provider.dart';

void main() {
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
        // ChangeNotifierProvider(create: (context) => PriceSummary()),
        ChangeNotifierProvider(create: (context) => CartItemsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        theme: ThemeData(
          primaryColor: AppColors.primary,
        ),
        home: HomePage(),
      ),
    );
  }
}
