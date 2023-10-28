import 'package:flutter/material.dart';

enum GapDirection { row, column }

class GapWidget extends StatelessWidget {
  const GapWidget({super.key, required this.gapDirection, this.gap = 10.0});
  final GapDirection gapDirection;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: gapDirection == GapDirection.column ? gap : 0,
      width: gapDirection == GapDirection.row ? gap : 0,
    );
  }
}
