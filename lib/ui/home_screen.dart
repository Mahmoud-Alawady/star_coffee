import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/ui/components/clip_bottom_bar.dart';
import 'package:star_coffee/ui/components/drinks_grid.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_styles.dart';

class HomePage extends StatelessWidget {
  int _selectedCategory = 0;
  int _selectedPage = 0;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildAppBar(),
      body: buildBody(),
      extendBody: true,
      bottomNavigationBar: buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  buildAppBar() {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.secondary,
      ),
      toolbarHeight: 85,
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: IconButton(
          icon: SvgPicture.asset(
            height: 16,
            width: 16,
            AppPaths.menuIcon,
            semanticsLabel: 'menu drawer',
            fit: BoxFit.contain,
          ),
          onPressed: () {},
        ),
      ),
      centerTitle: true,
      title: Text(
        'StarCoffee',
        style: AppStyles.getTextStyle(22),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              height: 24,
              width: 24,
              AppPaths.searchIcon,
              semanticsLabel: 'search',
              fit: BoxFit.contain,
            ),
          ),
        )
      ],
      backgroundColor: AppColors.background,
      elevation: 0,
    );
  }

  buildBody() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              elevation: 0,
              expandedHeight: 100,
              backgroundColor: AppColors.background,
              title: buildWelcomeText(),
              forceElevated: innerBoxIsScrolled,
              pinned: false,
            ),
          ),
        ];
      },
      body: buildNavRailWithGrid(),
    );
  }

  buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            AppStrings.welcome,
            style:
                AppStyles.getTextStyle(16, AppColors.primaryLight, 'Poppins'),
          ),
          Text(
            AppStrings.name,
            style: AppStyles.getTextStyle(20),
          )
        ],
      ),
    );
  }

  buildNavRailWithGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(flex: 1, child: buildNavigationRail()),
        Expanded(flex: 6, child: DrinksGrid())
      ],
    );
  }

  buildNavigationRail() {
    return Container(
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
          buildNavigationRailDestination('Hot Tea'),
          buildNavigationRailDestination('Hot Tea'),
          buildNavigationRailDestination('Hot Tea'),
          buildNavigationRailDestination('Hot Tea'),
        ],
      ),
    );
  }

  buildNavigationRailDestination(String text, [double? padding]) {
    return NavigationRailDestination(
      icon: const SizedBox.shrink(),
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: padding ?? 0),
        child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            text,
            // softWrap: false,
          ),
        ),
      ),
    );
  }

  buildBottomNavigationBar() {
    return SizedBox(
      height: 120,
      child: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: ClipBottomBar(),
            child: Container(
              height: 120,
              color: AppColors.secondary,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNavigationBarIcon(AppPaths.cartIcon, 0),
                  buildNavigationBarIcon(AppPaths.bookIcon, 1),
                  const SizedBox(width: 80),
                  buildNavigationBarIcon(AppPaths.heartIcon, 2),
                  buildNavigationBarIcon(AppPaths.profileIcon, 3),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(
              width: 85,
              height: 85,
              child: FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: () {
                  _selectedPage = 4;
                  print('_selectedPage: $_selectedPage');
                },
                elevation: 0,
                child: SvgPicture.asset(
                  height: 26,
                  width: 26,
                  AppPaths.homeIcon,
                  theme: const SvgTheme(currentColor: AppColors.background),
                ),
              ),
            ),
            const SizedBox(height: 26) //fab bottom elevation
          ]),
        ),
      ]),
    );
  }

  buildNavigationBarIcon(String icon, int index) {
    return IconButton(
      padding:
          const EdgeInsets.only(bottom: 22), //nav bar icons bottom elevation
      onPressed: () {
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
}
