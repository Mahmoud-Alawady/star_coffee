import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/constants/app_styles.dart';
import 'package:star_coffee/data/cart_database.dart';
import 'package:star_coffee/data/cart_item.dart';
import 'package:star_coffee/ui/components/clip_drink_image.dart';
import '../data/drink.dart';
import 'components/clip_bottom_bar.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sqflite/sqflite.dart';

class DrinkDetails extends StatelessWidget {
  final Drink _drink;
  CartItem _cartItem;
  late BuildContext context;

  DrinkDetails({drink, super.key})
      : _drink = drink,
        _cartItem =
            CartItem(drink: drink, milkAmount: 50, size: 1, quantity: 1);

  @override
  Widget build(BuildContext context) {
    Widget ingredients = Text('Ingredients', style: AppStyles.getTextStyle());
    Widget coffeeSize = Text('Coffee Size', style: AppStyles.getTextStyle());

    this.context = context;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(children: [
          SingleChildScrollView(
            child: Dismissible(
              key: const Key('dismiss drink details'),
              direction: DismissDirection.down,
              onDismissed: (direction) {
                Navigator.of(context).pop();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildClippedImage(),
                  // ingredients,
                  // buildSlider(),
                  SizedBox(
                    height: 100,
                  ),
                  coffeeSize,
                  buildCoffeeSizeSelect(),
                  buildQuantitySelect(),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
          buildDrinkTitle(),
          buildBottomBar(),
        ]),
      ),
    );
  }

  buildClippedImage() {
    return ClipPath(
      clipBehavior: Clip.antiAlias,
      clipper: ClipDrinkImage(),
      child: buildImageWithShadow(),
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
        child: Image.network(_drink.image, fit: BoxFit.cover),
      ),
    );
  }

  buildBottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipBehavior: Clip.antiAlias,
        clipper: ClipBottomBar(),
        child: InkWell(
          onTap: () {
            CartDatabase.insertRecord(
              _drink.image,
              _drink.title,
              _drink.subtitle,
              _drink.price,
              _drink.rate,
              _cartItem.milkAmount,
              _cartItem.size,
              _cartItem.quantity,
            );
          },
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            color: AppColors.secondary,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '\$ ${_drink.price}\nAdd to cart',
                style: AppStyles.getTextStyle(18, AppColors.background)
                    .copyWith(height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildSlider() {
    return SleekCircularSlider(
      min: 0,
      max: 100,
      initialValue: 50,
      onChange: (double value) {
        _cartItem.milkAmount = value;
        print('milkAmount: ${_cartItem.milkAmount}');
      },
      onChangeStart: (double startValue) {
        // callback providing a starting value (when a pan gesture starts)
      },
      onChangeEnd: (double endValue) {
        // callback providing an ending value (when a pan gesture ends)
      },
      innerWidget: (_) {
        return Center(
            child: Text(
          '${_cartItem.milkAmount.round()}%\nMilk',
          style: AppStyles.getTextStyle(16, AppColors.primary),
        ));
      },
      appearance: CircularSliderAppearance(),
    );

    // SliderTheme(
    //     data: SliderThemeData(
    //         thumbColor: AppColors.primary,
    //         activeTrackColor: AppColors.primary.withAlpha(160),
    //         inactiveTrackColor: AppColors.primary.withAlpha(160),
    //         trackShape: RoundedRectSliderTrackShape()),
    //     child: Slider(
    //       value: milkAmount,
    //       min: 0,
    //       max: 100,
    //       onChanged: (value) {
    //         setState(() {
    //           milkAmount = value;
    //         });
    //         print('_milkAmount: $milkAmount');
    //       },
    //     ));
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
        await CartDatabase.getRecord();
      },
    );
    Widget name = Text(
      _drink.title,
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

  buildQuantitySelect() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildQuantityEdit(false),
          Text(
            _cartItem.quantity.toString(),
            style: AppStyles.getTextStyle(),
          ),
          buildQuantityEdit(true),
        ],
      ),
    );
  }

  buildQuantityEdit(bool increase) {
    return IconButton(
        onPressed: () {
          increase
              ? _cartItem.quantity++
              : (_cartItem.quantity > 1)
                  ? _cartItem.quantity--
                  : print('can\'t have less that 1');
          print('quantity: ${_cartItem.quantity}');
        },
        icon: SvgPicture.asset(increase ? AppPaths.plus : AppPaths.minus));
  }

  buildCoffeeSizeSelect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildSize(0),
        buildSize(1),
        buildSize(2),
      ],
    );
  }

  buildSize(int i) {
    List<String> sizeTitle = ['Small', 'Medium', 'Large'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 120,
          child: Center(
            child: buildSizeIcon(i),
          ),
        ),
        Text(sizeTitle[i],
            style: AppStyles.getTextStyle(14,
                _cartItem.size == i ? Colors.black : Colors.grey, 'Poppins')),
      ],
    );
  }

  buildSizeIcon(int i) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      color: (_cartItem.size == i) ? AppColors.primary : Colors.white,
      child: InkWell(
        onTap: () {
          _cartItem.size = i;
          print('selectedSize: ${_cartItem.size}');
        },
        child: Ink(
          height: 72.0 + i * 16,
          width: 72.0 + i * 16,
          padding: const EdgeInsets.all(24),
          child: SvgPicture.asset(
            AppPaths.cup,
            colorFilter: (_cartItem.size == i)
                ? const ColorFilter.mode(Colors.white, BlendMode.srcATop)
                : const ColorFilter.mode(AppColors.primary, BlendMode.srcATop),
          ),
        ),
      ),
    );
  }
}

// class BasePainter extends CustomPainter {
//   Color baseColor;

//   late Offset center;
//   late double radius;

//   BasePainter({required this.baseColor});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = baseColor
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 12.0;

//     center = Offset(size.width / 2, size.height / 2);
//     // radius = min(size.width / 2, size.height / 2);
//     radius = size.width / 2;

//     canvas.drawCircle(center, radius, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
