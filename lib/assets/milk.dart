import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(8.777, 4.458);
    path_0.lineTo(10.792, 32);
    path_0.lineTo(25.125, 32);
    path_0.lineTo(27.314, 4.437999999999999);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffCCD6DD).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(25, 31.281);
    path_1.lineTo(10.906, 31.438);
    path_1.lineTo(9.888, 16.125999999999998);
    path_1.lineTo(26.134, 16.125999999999998);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffFFFFFF).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(23.906, 35.175);
    path_2.lineTo(12.094, 35.175);
    path_2.cubicTo(10.382, 35.175, 9.18, 34.022, 8.959, 32.163999999999994);
    path_2.lineTo(6.984, 4.448);
    path_2.arcToPoint(const Offset(8.073, 3.1930000000000005),
        radius: const Radius.elliptical(1.175, 1.175),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(const Offset(9.328, 4.281000000000001),
        radius: const Radius.elliptical(1.169, 1.169),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.lineTo(11.296999999999999, 31.941000000000003);
    path_2.cubicTo(11.403999999999998, 32.825, 11.87, 32.825, 12.094, 32.825);
    path_2.lineTo(23.906, 32.825);
    path_2.cubicTo(
        24.421999999999997, 32.825, 24.613999999999997, 32.825, 24.706, 31.908);
    path_2.lineTo(26.672, 4.281000000000002);
    path_2.arcToPoint(const Offset(29.016000000000002, 4.448000000000002),
        radius: const Radius.elliptical(1.175, 1.175),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.lineTo(27.047, 32.107);
    path_2.cubicTo(26.795, 34.647999999999996, 25.2, 35.175, 23.906, 35.175);

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0xff8899A6).withOpacity(1.0);
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(18, 33);
    path_3.lineTo(15.373000000000001, 33);
    path_3.cubicTo(
        9.841000000000001, 33, 9.206000000000001, 30.316, 8.913, 26.526);
    path_3.cubicTo(8.585, 22.295, 7.16, 4.432, 7.16, 4.432);
    path_3.lineTo(9.153, 4.273000000000001);
    path_3.cubicTo(9.153, 4.273000000000001, 10.58, 22.141, 10.907, 26.372);
    path_3.cubicTo(
        11.172, 29.811, 11.463000000000001, 31, 15.373000000000001, 31);
    path_3.lineTo(18, 31);
    path_3.arcToPoint(const Offset(18, 33),
        radius: const Radius.elliptical(1, 1),
        rotation: 0,
        largeArc: true,
        clockwise: true);

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = const Color(0xff8899A6).withOpacity(1.0);
    canvas.drawPath(path_3, paint3Fill);

    Path path_4 = Path();
    path_4.moveTo(20.627, 33);
    path_4.lineTo(18, 33);
    path_4.arcToPoint(const Offset(18, 31),
        radius: const Radius.elliptical(1, 1),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path_4.lineTo(20.627, 31);
    path_4.cubicTo(24.537, 31, 24.826999999999998, 29.811, 25.093, 26.372);
    path_4.cubicTo(25.421, 22.14, 26.847, 4.273, 26.847, 4.273);
    path_4.lineTo(28.841, 4.4319999999999995);
    path_4.cubicTo(
        28.841, 4.4319999999999995, 27.415000000000003, 22.296, 27.087, 26.526);
    path_4.cubicTo(26.794, 30.316, 26.16, 33, 20.627, 33);

    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = const Color(0xff8899A6).withOpacity(1.0);
    canvas.drawPath(path_4, paint4Fill);

    Path path_5 = Path();
    path_5.moveTo(29, 4.083);
    path_5.cubicTo(29, 5.7860000000000005, 26.27, 7.166, 18, 7.166);
    path_5.cubicTo(9.731, 7.166, 7, 5.7860000000000005, 7, 4.083);
    path_5.cubicTo(7, 2.38, 9.73, 1, 18, 1);
    path_5.cubicTo(26.27, 1, 29, 2.38, 29, 4.083);

    Paint paint5Fill = Paint()..style = PaintingStyle.fill;
    paint5Fill.color = const Color(0xffCCD6DD).withOpacity(1.0);
    canvas.drawPath(path_5, paint5Fill);

    Path path_6 = Path();
    path_6.moveTo(28.532, 4.128);
    path_6.arcToPoint(const Offset(27.145, 3.8520000000000003),
        radius: const Radius.elliptical(1, 1),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.cubicTo(25.059, 5.245, 19.871, 5.423, 18.048000000000002, 5.375);
    path_6.cubicTo(
        18.038, 5.374, 18.029000000000003, 5.38, 18.019000000000002, 5.379);
    path_6.cubicTo(
        18.01, 5.379, 18.003000000000004, 5.375, 17.994000000000003, 5.375);
    path_6.cubicTo(16.175000000000004, 5.424, 10.986000000000004, 5.248,
        8.897000000000004, 3.8520000000000003);
    path_6.arcToPoint(const Offset(7.786000000000004, 5.515000000000001),
        radius: const Radius.elliptical(1, 1),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.cubicTo(10.356000000000003, 7.232000000000001, 15.703000000000003,
        7.381, 17.474000000000004, 7.381);
    path_6.cubicTo(17.763000000000005, 7.381, 17.951000000000004,
        7.377000000000001, 18.021000000000004, 7.375);
    path_6.cubicTo(18.092000000000006, 7.377, 18.279000000000003, 7.381,
        18.568000000000005, 7.381);
    path_6.cubicTo(20.339000000000006, 7.381, 25.686000000000007,
        7.2330000000000005, 28.256000000000007, 5.515000000000001);
    path_6.arcToPoint(const Offset(28.532000000000007, 4.128),
        radius: const Radius.elliptical(0.998, 0.998),
        rotation: 0,
        largeArc: false,
        clockwise: false);

    Paint paint6Fill = Paint()..style = PaintingStyle.fill;
    paint6Fill.color = const Color(0xffFFFFFF).withOpacity(1.0);
    canvas.drawPath(path_6, paint6Fill);

    Paint paint7Fill = Paint()..style = PaintingStyle.fill;
    paint7Fill.color = const Color(0xffE1E8ED).withOpacity(1.0);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.4997500, size.height * 0.4461111),
            width: size.width * 0.4348333,
            height: size.height * 0.08133333),
        paint7Fill);

    // Path path_8 = Path();
    // path_8.moveTo(11.042, 31.542);
    // path_8.lineTo(25.209, 31.542);
    // path_8.lineTo(25.209, 33.375);
    // path_8.lineTo(11.042, 33.375);
    // path_8.close();

    // Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    // paint_8_fill.color = const Color(0xff8899A6).withOpacity(1.0);
    // canvas.drawPath(path_8, paint_8_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
