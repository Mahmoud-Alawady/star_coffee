import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/constants/globals.dart' as globals;
import 'package:star_coffee/constants/app_styles.dart';
import 'package:star_coffee/presentation/components/bottom_bar.dart';
import 'package:star_coffee/presentation/components/price_summary.dart';
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
          context.read<CartProvider>().editMode = true;
        });
    return CustomAppBar(
      myLeading: backButton,
      myTitle: 'Cart',
      myActions: editButton,
    );
  }

  edit() {
    // context.read<CartItemsProvider>().deleteDB();
  }

  buildBody() {
    if (context.watch<CartProvider>().itemsLoaded) {
      return buildBodyContent();
    } else {
      context.read<CartProvider>().getCartItemsFromDB();
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
      child: Text('My Order', style: TextStyles.titleXL.secondary),
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
      text:
          '\$ ${context.watch<CartProvider>().priceSummary.total}\nProceed to checkout',
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
