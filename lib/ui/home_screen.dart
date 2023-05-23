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
  late BuildContext context;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildAppBar(),
      body: buildBody(),
      resizeToAvoidBottomInset: false,
    );
  }

  buildAppBar() {
    Widget menuIcon = _buildIconButton('menu', AppPaths.menuIcon, 16);
    Widget searchIcon = _buildIconButton('search', AppPaths.searchIcon, 24);
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.secondary,
      ),
      toolbarHeight: 85,
      leadingWidth: 80,
      leading: menuIcon,
      centerTitle: true,
      title: Text('StarCoffee', style: AppStyles.getTextStyle(22)),
      actions: [searchIcon],
      backgroundColor: AppColors.background,
      elevation: 0,
    );
  }

  _buildIconButton(
      [String? label, String? icon, double? size, VoidCallback? function]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: IconButton(
        icon: SvgPicture.asset(
          icon!,
          height: size ?? 24,
          width: size ?? 24,
          semanticsLabel: label,
          fit: BoxFit.contain,
        ),
        onPressed: function,
      ),
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
      body: Stack(
        children: [
          buildNavRailWithGrid(),
          buildBottomNavBar(),
          buildHomeButton(),
        ],
      ),
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
          buildNavRailDestination('Hot Tea'),
          buildNavRailDestination('Hot Tea'),
          buildNavRailDestination('Hot Tea'),
          buildNavRailDestination('Hot Tea'),
          buildNavRailDestination('Hot Tea'),
        ],
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
              buildNavBarIcon(AppPaths.cartIcon, 1),
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

  buildNavBarIcon(String icon, int index) {
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

  buildHomeButton() {
    return Positioned(
      bottom: 24,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
            onPressed: () {
              _selectedPage = 0;
              print('_selectedPage: $_selectedPage');
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
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
