import 'package:flutter/material.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/constants/app_styles.dart';
import 'package:star_coffee/data/cart_database.dart';
import 'package:star_coffee/data/cart_item.dart';
import 'package:star_coffee/ui/components/clip_bottom_bar.dart';
import 'package:star_coffee/ui/components/clip_summary.dart';
import 'components/app_components.dart';
import 'components/cart_drinks_list.dart';

class Cart extends StatelessWidget {
  late BuildContext context;
  late Size screenSize;

  double subtotal = 0;
  double total = 0;
  double shippingCost = 1;
  double taxes = 1;

  double horizontalPadding = 26;

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
    Widget backButton = MyAppComponents.buildIconButton(
        icon: AppPaths.backIcon,
        function: () {
          Navigator.of(context).pop();
        });
    Widget editButton = MyAppComponents.buildIconButton(
        icon: AppPaths.editIcon,
        function: () {
          CartDatabase.deleteDB();
        });
    return MyAppComponents.myAppBar(
      myLeading: backButton,
      myTitle: 'Cart',
      myActions: [editButton],
    );
  }

  buildBody() {
    return FutureBuilder(
      future: CartDatabase.getCartItems(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return buildContent(snapshot.data);
        }
      },
    );
  }

  buildBottomBar() {
    return MyAppComponents.myBottomBar(
      context: context,
      text: '\$ $total\nProceed to checkout',
      function: () {},
    );
  }

  Widget buildContent(List<CartItem>? data) {
    Widget myOrder = Padding(
      padding: EdgeInsets.only(left: horizontalPadding, top: 4),
      child: Text('My Order', style: AppStyles.getTextStyle(22)),
    );
    Widget itemsCount = Padding(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
      child: RichText(
          text: TextSpan(
              text: 'You Have ',
              style: AppStyles.getTextStyle(15, AppColors.secondary, 'Poppins'),
              children: [
            TextSpan(
                text: '${data!.length} items ',
                style:
                    AppStyles.getTextStyle(15, AppColors.primary, 'Poppins')),
            TextSpan(
                text: 'in your cart',
                style:
                    AppStyles.getTextStyle(15, AppColors.secondary, 'Poppins')),
          ])),
    );
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myOrder,
              itemsCount,
              CartDrinksList(cartItems: data),
            ],
          ),
        ),
        buildSummary(data),
        buildBottomBar(),
      ],
    );
  }

  buildSummary(List<CartItem> data) {
    for (int i = 0; i < data.length; i++) {
      subtotal += data[i].drink.price * data[i].quantity;
    }
    total = subtotal + shippingCost + taxes;
    Widget div = const Divider(
      color: AppColors.background,
      height: 22,
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: ClipSummary(),
        child: Container(
          height: screenSize.height * 0.45,
          color: AppColors.primary,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildSummaryRow('Subtotal', subtotal),
                div,
                buildSummaryRow('Shipping Cost', shippingCost),
                div,
                buildSummaryRow('Taxes', taxes),
                div,
                buildSummaryRow('Total', total),
                div,
                SizedBox(height: MyAppComponents.bottomBarHeight - 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildSummaryRow(String text, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyles.getTextStyle(16, AppColors.background),
        ),
        Text(
          '\$ $value',
          style: AppStyles.getTextStyle(16, AppColors.background),
        ),
      ],
    );
  }
}
