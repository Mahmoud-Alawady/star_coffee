import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/constants/text_styles.dart';
import 'package:star_coffee/data/cart_item.dart';
import 'package:star_coffee/presentation/components/bottom_bar.dart';
import 'package:star_coffee/presentation/components/clip_round_bottom.dart';
import 'package:star_coffee/presentation/components/no_glow_scroll_behavior.dart';
import 'package:star_coffee/providers/cart_provider.dart';
import '../constants/app_strings.dart';
import '../data/drink.dart';
import 'components/custom_slider.dart';
import 'components/drink_size_select.dart';
import 'components/quantity_select.dart';

class DrinkDetails extends StatelessWidget {
  late BuildContext context;
  final bool edit;
  final int index;
  final String imageTag;
  CartItem cartItem;

  DrinkDetails.fromCart({
    super.key,
    required this.cartItem,
    required this.index,
  })  : edit = true,
        imageTag = AppStrings.listImageTag + index.toString();

  DrinkDetails.fromHome({
    super.key,
    required Drink drink,
    required this.index,
  })  : edit = false,
        cartItem = CartItem(drink: drink, milkAmount: 50, size: 1, quantity: 1),
        imageTag = AppStrings.gridImageTag + index.toString();

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
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildClippedImage(),
            Text(
              'Ingredients',
              style: TextStyles.title.secondary.s14,
            ),
            buildSlider(),
            const SizedBox(height: 16),
            DrinkSizeSelect(
                size: cartItem.size,
                onSizeSelected: (newSize) {
                  cartItem.size = newSize;
                }),
            const SizedBox(height: 6),
            QuantitySelect(
              quantity: cartItem.quantity,
              onQuantitySelected: (newQuantity) {
                cartItem.quantity = newQuantity;
              },
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  Widget buildClippedImage() {
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

  Widget buildSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: LayoutBuilder(
        builder: (_, constraints) {
          return CustomSlider(
            initValue: cartItem.milkAmount.toDouble(),
            onChange: (newValue) {
              cartItem.milkAmount = newValue;
            },
            boxWidth: constraints.maxWidth,
          );
        },
      ),
    );
  }

  buildBottomBar() {
    return BottomBar(
      text: '\$ ${cartItem.drink.price}\nAdd to cart',
      function: () {
        edit
            ? context
                .read<CartProvider>()
                .editCartItem(cartItem: cartItem, index: index)
            : context.read<CartProvider>().addItem(item: cartItem);
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
        // await CartDatabase.getCartItems();
      },
    );
    Widget name = Text(
      cartItem.drink.title,
      style: TextStyles.titleL.white,
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
