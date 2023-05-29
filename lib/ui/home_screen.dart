import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/ui/cart.dart';
import 'package:star_coffee/ui/components/app_components.dart';
import 'package:star_coffee/ui/components/clip_bottom_bar.dart';
import 'package:star_coffee/ui/components/drinks_grid.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_styles.dart';
import '../data/drink.dart';
import 'drink_details.dart';

class HomePage extends StatelessWidget {
  int _selectedCategory = 0;
  int _selectedPage = 0;
  late Size screenSize;
  late double navRailWidth;
  late double navRailHeight;

  late BuildContext context;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    screenSize = MediaQuery.of(context).size;
    navRailWidth = screenSize.width * 0.15;
    navRailHeight = (screenSize.height - MyAppComponents.appBarHeight) * 0.84;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildAppBar(),
      body: buildBody(),
      resizeToAvoidBottomInset: false,
    );
  }

  menuFunction() {}

  buildAppBar() {
    Widget menuIcon = MyAppComponents.buildIconButton(
      label: 'menu',
      icon: AppPaths.menuIcon,
      function: menuFunction,
    );
    Widget searchIcon = MyAppComponents.buildIconButton(
      label: 'search',
      icon: AppPaths.searchIcon,
      function: () {},
    );
    return MyAppComponents.myAppBar(
      myLeading: menuIcon,
      myTitle: 'StarCoffee',
      myActions: [searchIcon],
    );
  }

  buildBody() {
    return Stack(
      children: [
        // Cart(),
        browseDrinks(),
        buildNavRail(),
        buildBottomNavBar(),
        buildHomeButton(),
      ],
    );
  }

  browseDrinks() {
    return
        // SingleChildScrollView(
        //   physics: const BouncingScrollPhysics(),
        //   child: Expanded(
        //     child:
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildWelcomeText(),
        Expanded(child: buildDrinksGrid()),
      ],
    );
  }

  buildWelcomeText() {
    Widget welcome = Text(AppStrings.welcome,
        style: AppStyles.getTextStyle(16, AppColors.primaryLight, 'Poppins'));
    Widget name = Text(AppStrings.name, style: AppStyles.getTextStyle(20));
    return Padding(
      padding: const EdgeInsets.only(bottom: 36, left: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          welcome,
          name,
        ],
      ),
    );
  }

  buildDrinksGrid() {
    return Padding(
      padding: EdgeInsets.only(left: navRailWidth),
      child: DrinksGrid(
        drinks: [
          Drink.dump0(),
          Drink.dump1(),
          Drink.dump2(),
          Drink.dump3(),
          Drink.dump4(),
          Drink.dump1(),
          Drink.dump3(),
          Drink.dump2(),
          Drink.dump0(),
          Drink.dump4(),
        ],
      ),
    );
  }

  buildNavRail() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: navRailWidth,
        height: navRailHeight,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(38))),
        child: NavigationRail(
          backgroundColor: AppColors.primary,
          labelType: NavigationRailLabelType.all,
          selectedLabelTextStyle: AppStyles.getTextStyle(16, Colors.white),
          unselectedLabelTextStyle:
              AppStyles.getTextStyle(16, AppColors.primaryLight),
          selectedIndex: _selectedCategory,
          onDestinationSelected: (int index) {
            _selectedCategory = index;
            print('_selectedCategory: $_selectedCategory');
          },
          destinations: [
            buildNavRailDestination('Hot Tea'),
            buildNavRailDestination('Hot Tea'),
            buildNavRailDestination('Hot Tea'),
            buildNavRailDestination('Hot Tea'),
            buildNavRailDestination('Hot Tea'),
          ],
        ),
      ),
    );
  }

  buildNavRailDestination(String text, [double? padding]) {
    return NavigationRailDestination(
      icon: const SizedBox.shrink(),
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: padding ?? 0),
        child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            text,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  buildBottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipBehavior: Clip.antiAlias,
        clipper: ClipBottomBar(),
        child: Container(
          height: 120,
          color: AppColors.secondary,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNavBarIcon(AppPaths.cartIcon, 1, function: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Cart();
                  },
                ));
              }),
              buildNavBarIcon(AppPaths.bookIcon, 2),
              const SizedBox(width: 80),
              buildNavBarIcon(AppPaths.heartIcon, 3),
              buildNavBarIcon(AppPaths.profileIcon, 4),
            ],
          ),
        ),
      ),
    );
  }

  buildNavBarIcon(String icon, int index, {VoidCallback? function}) {
    return IconButton(
      padding:
          const EdgeInsets.only(bottom: 22), //nav bar icons bottom elevation
      onPressed: function ??
          () {
            _selectedPage = index;
            print('_selectedPage: $_selectedPage');
          },
      icon: SvgPicture.asset(
        icon,
        theme: const SvgTheme(currentColor: AppColors.background),
        width: 22,
        height: 22,
        fit: BoxFit.contain,
      ),
    );
  }

  buildHomeButton() {
    return Positioned(
      bottom: 24,
      width: screenSize.width,
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
            onPressed: () {
              _selectedPage = 0;
              print('_selectedPage: $_selectedPage');
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                fixedSize: MaterialStateProperty.all(const Size(84, 84)),
                backgroundColor: MaterialStateProperty.all(AppColors.primary)),
            child: SvgPicture.asset(
              AppPaths.homeIcon,
              height: 28,
              width: 28,
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
