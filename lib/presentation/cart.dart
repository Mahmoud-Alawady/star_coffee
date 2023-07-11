import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/constants/app_sizes.dart';
import 'package:star_coffee/constants/app_styles.dart';
import 'package:star_coffee/presentation/components/bottom_bar.dart';
import 'package:star_coffee/presentation/components/price_summary.dart';
import '../providers/cart_items_provider.dart';
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
          context.read<CartItemsProvider>().deleteDB();
        });
    return CustomAppBar(
      myLeading: backButton,
      myTitle: 'Cart',
      myActions: [editButton],
    );
  }

  buildBody() {
    if (context.watch<CartItemsProvider>().itemsLoaded) {
      return buildBodyContent();
    } else {
      context.read<CartItemsProvider>().getCartItemsFromDB();
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
      padding: EdgeInsets.only(left: AppSizes.horizontalPadding, top: 4),
      child: Text('My Order', style: AppStyles.getTextStyle(22)),
    );
    Widget itemsCount = Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding, vertical: 12),
      child: RichText(
          text: TextSpan(
              text: 'You Have ',
              style: AppStyles.getTextStyle(15, AppColors.secondary, 'Poppins'),
              children: [
            TextSpan(
                text:
                    '${context.watch<CartItemsProvider>().cartItemsCount} items ',
                style:
                    AppStyles.getTextStyle(15, AppColors.primary, 'Poppins')),
            TextSpan(
                text: 'in your cart',
                style:
                    AppStyles.getTextStyle(15, AppColors.secondary, 'Poppins')),
          ])),
    );
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myOrder,
          itemsCount,
          DrinksList(cartItems: context.watch<CartItemsProvider>().cartItems),
        ],
      ),
    );
  }

  buildSummary() {
    return PriceSummary(p: context.watch<CartItemsProvider>().priceSummary);
  }

  buildBottomBar() {
    return BottomBar(
      text:
          '\$ ${context.watch<CartItemsProvider>().priceSummary.total}\nProceed to checkout',
      function: () {},
    );
  }

  // _showError() {
  //   return Center(
  //     child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           const Padding(
  //               padding: EdgeInsets.all(24.0),
  //               child: Icon(
  //                 Icons.error,
  //                 size: 150,
  //                 color: Color.fromARGB(255, 112, 109, 109),
  //               )),
  //           Text(cartItemsProvider.error.toString()),
  //           MaterialButton(
  //             onPressed: () {
  //               cartItemsProvider.refresh();
  //             },
  //             color: AppColors.primary,
  //             shape: const RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(12))),
  //             child: const Text('Refresh'),
  //           )
  //         ]),
  //   );
  // }
}
