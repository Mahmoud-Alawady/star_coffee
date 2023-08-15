import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/app_paths.dart';
import 'package:star_coffee/constants/text_styles.dart';

class CustomSlider extends StatefulWidget {
  final double initValue;
  final void Function(int newValue) onChange;
  final double boxWidth;

  const CustomSlider({
    required this.initValue,
    required this.onChange,
    required this.boxWidth,
    super.key,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final Color color = AppColors.primary;
  late double value;
  late double boxHeight;
  late double initThumbWidth;
  late double thumbWidth;

  late double maxYLoc;
  late double xLoc;
  late double yLoc;

  @override
  void initState() {
    value = widget.initValue;
    boxHeight = widget.boxWidth * 0.28;
    initThumbWidth = widget.boxWidth * 0.12;
    thumbWidth = initThumbWidth;

    maxYLoc = boxHeight * 0.18;
    xLoc = calcXLoc();
    yLoc = calcYLoc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Stack(
            children: [
              _buildTrack(),
              _buildThumb(),
            ],
          ),
        );
      },
    );
  }

  _buildTrack() {
    return CustomPaint(
      willChange: false,
      size: Size(widget.boxWidth, boxHeight),
      painter: TrackPainter(color, value.round()),
    );
  }

  _buildThumb() {
    return Positioned(
      left: xLoc,
      bottom: yLoc,
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          setState(() {
            thumbWidth += 4;
          });
        },
        onHorizontalDragUpdate: (details) {
          setState(() {
            value = calcValue(details.delta.dx);
            xLoc = calcXLoc();
            yLoc = calcYLoc();
            widget.onChange(value.round());
          });
        },
        onHorizontalDragEnd: (details) {
          setState(() {
            thumbWidth -= 4;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOutCubic,
          width: thumbWidth,
          height: thumbWidth,
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(90))),
          child: SvgPicture.asset(
            AppPaths.sliderThumbIcon,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  double quadFun(double x) {
    //quadratic equation of track curve
    return -(0.02 * x - 1) * (0.02 * x - 1) + 1.62;
  }

  double calcYLoc() {
    double factor = quadFun(value);
    return factor * maxYLoc;
  }

  double calcXLoc() {
    double min = widget.boxWidth * 0.2;
    double range = widget.boxWidth * 0.6;
    double x = value / 100 * range;
    return min + x - initThumbWidth * 0.5;
  }

  double calcValue(double dx) {
    double newValue = value;
    double change = 0.5 * dx;
    newValue += change;
    return newValue.clamp(0, 100);
  }
}

class TrackPainter extends CustomPainter {
  int value;
  final Color color;
  final pi = 3.14159265358;
  final double pointWidth = 14;

  TrackPainter(this.color, this.value);

  @override
  void paint(Canvas canvas, Size size) {
    //curve
    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final colors = [
      Colors.transparent,
      color.withAlpha(160),
      color.withAlpha(160),
      Colors.transparent,
    ];
    const List<double> stops = [0.12, 0.2, 0.8, 0.88];
    final trackGradient = LinearGradient(
        colors: colors,
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight,
        stops: stops);
    Paint curvePaint = Paint()
      ..shader = trackGradient.createShader(rect)
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(
        0, //start point
        size.height,
      )
      ..quadraticBezierTo(
        size.width / 2, //middle point
        0,
        size.width, //end point
        size.height,
      );
    canvas.drawPath(path, curvePaint);

    //points
    Paint pointPaint = Paint()
      ..color = color.withAlpha(200)
      ..style = PaintingStyle.stroke
      ..strokeWidth = pointWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(
        PointMode.points,
        [
          Offset(pointWidth / 2, size.height),
          Offset(size.width - pointWidth / 2, size.height)
        ],
        pointPaint);

    //text
    final TextPainter milkTextPainter = TextPainter(
        text: TextSpan(
          text: '$value% Milk',
          style: TextStyles.title.s12.primary,
        ),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: size.width);

    milkTextPainter.paint(
        canvas,
        Offset(size.width / 2 - (milkTextPainter.width / 2),
            size.height - pointWidth / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
