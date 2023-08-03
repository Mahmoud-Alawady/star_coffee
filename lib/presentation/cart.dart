import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/constants/globals.dart' as globals;
import 'package:star_coffee/presentation/components/bottom_bar.dart';
import 'package:star_coffee/presentation/components/price_summary.dart';
import '../constants/text_styles.dart';
import '../providers/cart_provider.dart';
import 'components/custom_app_bar.dart';
import 'components/custom_icon_button.dart';
import 'components/drinks_list.dart';

class Cart extends StatelessWidget {
  late BuildContext context;
  late Size screenSize;

  Cart({super.key});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  buildAppBar() {
    Widget backButton = CustomIconButton(
        icon: AppPaths.backIcon,
        function: () {
          Navigator.of(context).pop();
        });
    Widget editButton = CustomIconButton(
        icon: AppPaths.editIcon,
        function: () {
          context.read<CartProvider>().toggleEditMode();
        });
    return CustomAppBar(
      myLeading: backButton,
      myTitle: context.watch<CartProvider>().editMode ? 'edit Items' : 'Cart',
      style: context.watch<CartProvider>().editMode
          ? TextStyles.titleL.secondary
          : null,
      myActions: editButton,
    );
  }

  buildBody() {
    if (context.watch<CartProvider>().itemsLoaded) {
      return buildBodyContent();
    } else {
      context.read<CartProvider>().getItems();
      return Container(color: AppColors.background);
    }
  }

  Widget buildBodyContent() {
    return Stack(
      children: [
        buildItems(),
        buildSummary(),
        buildBottomBar(),
      ],
    );
  }

  buildItems() {
    Widget myOrder = Padding(
      padding: EdgeInsets.only(left: globals.horizontalPadding, top: 4),
      child: Text('My Order', style: TextStyles.titleL.secondary),
    );
    Widget itemsCount = Padding(
      padding: EdgeInsets.symmetric(
          horizontal: globals.horizontalPadding, vertical: 12),
      child: RichText(
          text: TextSpan(
              text: 'You Have ',
              style: TextStyles.body.secondary,
              children: [
            TextSpan(
                text: '${context.watch<CartProvider>().cartItemsCount} items ',
                style: TextStyles.body.primary),
            TextSpan(text: 'in your cart', style: TextStyles.body.secondary),
          ])),
    );
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myOrder,
          itemsCount,
          DrinksList(cartItems: context.watch<CartProvider>().cartItems),
        ],
      ),
    );
  }

  buildSummary() {
    return PriceSummary(p: context.watch<CartProvider>().priceSummary);
  }

  buildBottomBar() {
    return BottomBar(
      text: context.watch<CartProvider>().editMode
          ? 'Remove Items\n'
          : '\$ ${context.watch<CartProvider>().priceSummary.total}\nProceed to checkout',
      function: context.read<CartProvider>().editMode
          ? () {
              context.read<CartProvider>().deleteSelected();
            }
          : () {},
    );
  }
}
