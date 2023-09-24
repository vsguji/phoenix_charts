import 'package:flutter/material.dart';

/// 绘制基础类
abstract class BasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size);

  @override
  bool shouldRepaint(CustomPainter oldDelegate);
}
