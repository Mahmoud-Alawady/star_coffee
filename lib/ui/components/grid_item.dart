import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class GridItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final double price;
  final double rate;

  GridItem(
      {required this.image,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.rate,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          buildBody(),
          buildImage(),
        ],
      ),
    );
  }

  buildImage() {
    return Positioned(
        top: -45,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                image,
                fit: BoxFit.cover,
                height: 90,
                width: 90,
              ),
            ),
          ],
        ));
  }

  buildBody() {
    return Stack(
      children: [buildContent(), buildAddIcon()],
    );
  }

  buildContent() {
    return Container(
      // constraints: const BoxConstraints(maxWidth: 150, maxHeight: 300),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(26))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            emptyBox(36),
            Text(title, style: AppStyles.getTextStyle(16, AppColors.secondary)),
            Text(subtitle,
                style: AppStyles.getTextStyle(
                    14, AppColors.primaryLight, 'Poppins')),
            emptyBox(4),
            Text(
              '  \$ $price',
              style: AppStyles.getTextStyle(16, AppColors.secondary),
            ),
            buildRow(Icons.star, rate.toString())
          ],
        ),
      ),
    );
  }

  buildAddIcon() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(26),
                topLeft: Radius.circular(26))),
        child: InkWell(
          onTap: () {
            print('Hello');
            // add function
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  emptyBox(double height) {
    return Container(
      height: height,
    );
  }

  buildRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.yellow,
          size: 26,
        ),
        Text(text, style: AppStyles.getTextStyle(16, Colors.black, 'Poppins')),
      ],
    );
  }
}
