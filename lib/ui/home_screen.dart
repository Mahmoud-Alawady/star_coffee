import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_styles.dart';

class HomePage extends StatelessWidget {
  int _selectedCategory = 0;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  buildAppBar() {
    return AppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: AppColors.background),
      toolbarHeight: 80,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/menu_icon.svg',
          semanticsLabel: 'menu drawer',
        ),
        onPressed: () {},
      ),
      centerTitle: true,
      title: Text(
        'StarCoffee',
        style: AppStyles.getTextStyle(22),
      ),
      actions: [
        IconButton(
            padding: const EdgeInsets.all(18),
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/search_icon.svg',
              semanticsLabel: 'search',
              fit: BoxFit.scaleDown,
            ))
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.welcome,
            style: AppStyles.getTextStyle(16, AppColors.primary),
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
        Expanded(flex: 2, child: buildNavigationRail()),
        Expanded(
            flex: 11,
            child: Container(
              color: Colors.grey,
              child: const Center(
                child: Text('Drinks Grid'),
              ),
            ))
      ],
    );
  }

  buildNavigationRail() {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 500,
      width: 60,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(38))),
      child: NavigationRail(
          selectedIndex: _selectedCategory,
          labelType: NavigationRailLabelType.all,
          backgroundColor: AppColors.primary,
          onDestinationSelected: (int index) {
            _selectedCategory = index;
          },
          selectedLabelTextStyle: AppStyles.getTextStyle(16, Colors.white),
          unselectedLabelTextStyle:
              AppStyles.getTextStyle(16, AppColors.primaryLight),
          destinations: [
            buildNavigationRailDestination('Hot Tea'),
            buildNavigationRailDestination('Iced Tea'),
          ]),
    );
  }

  buildVerticalText(String text, [double? padding]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding ?? 16),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(
          text,
          // softWrap: false,
        ),
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
}
