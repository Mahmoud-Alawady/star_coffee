import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/constants/app_styles.dart';
import 'package:star_coffee/data/cart_database.dart';
import 'package:star_coffee/data/cart_item.dart';
import 'package:star_coffee/presentation/components/bottom_bar.dart';
import 'package:star_coffee/presentation/components/clip_round_bottom.dart';
import 'package:star_coffee/providers/cart_items_provider.dart';
import '../data/drink.dart';
import 'components/drink_size_select.dart';
import 'components/quantity_select.dart';

class DrinkDetails extends StatelessWidget {
  late BuildContext context;
  final bool edit;
  final String imageTag;
  CartItem cartItem;

  DrinkDetails.fromCart(
      {super.key, required this.cartItem, required this.imageTag})
      : edit = true;
  DrinkDetails.fromHome(
      {super.key, required Drink drink, required this.imageTag})
      : edit = false,
        cartItem = CartItem(drink: drink, milkAmount: 50, size: 1, quantity: 1);

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: buildScreen(),
      ),
    );
  }

  buildScreen() {
    return Stack(children: [
      buildBody(),
      buildDrinkTitle(),
      buildBottomBar(),
    ]);
  }

  buildBody() {
    Widget drinkSize = Text('Coffee Size', style: AppStyles.getTextStyle());

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildClippedImage(),
        const SizedBox(height: 18),
        drinkSize,
        DrinkSizeSelect(
            size: cartItem.size,
            onSizeSelected: (newSize) {
              cartItem.size = newSize;
            }),
        const SizedBox(height: 24),
        QuantitySelect(
          quantity: cartItem.quantity,
          onQuantitySelected: (newQuantity) {
            cartItem.quantity = newQuantity;
          },
        ),
        const SizedBox(height: 120),
      ],
    );
  }

  buildClippedImage() {
    return Hero(
      tag: imageTag,
      child: ClipPath(
        clipBehavior: Clip.antiAlias,
        clipper: ClipRoundBottom(),
        child: buildImageWithShadow(),
      ),
    );
  }

  buildImageWithShadow() {
    return ShaderMask(
      shaderCallback: (bound) {
        return LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.2),
              Colors.transparent,
            ],
            stops: const [
              0,
              0.25,
              0.35,
            ]).createShader(bound);
      },
      blendMode: BlendMode.srcOver,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width,
        child: Image.network(cartItem.drink.image, fit: BoxFit.cover),
      ),
    );
  }

  buildBottomBar() {
    return BottomBar(
      text: '\$ ${cartItem.drink.price}\nAdd to cart',
      function: () {
        edit
            ? context.read<CartItemsProvider>().editCartItem(cartItem: cartItem)
            : context.read<CartItemsProvider>().insertItem(cartItem: cartItem);
      },
    );
  }

  buildDrinkTitle() {
    EdgeInsets buttonPadding = const EdgeInsets.symmetric(horizontal: 26);
    Widget back = IconButton(
      padding: buttonPadding,
      icon: SvgPicture.asset(AppPaths.backIcon),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget addToFav = IconButton(
      padding: buttonPadding,
      icon: SvgPicture.asset(AppPaths.addToFav),
      onPressed: () async {
        await CartDatabase.getCartItems();
      },
    );
    Widget name = Text(
      cartItem.drink.title,
      style: AppStyles.getTextStyle(20, Colors.white),
    );
    return Positioned(
      top: 44,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          back,
          name,
          addToFav,
        ],
      ),
    );
  }
}
