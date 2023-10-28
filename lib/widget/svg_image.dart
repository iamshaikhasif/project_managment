import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_mangment_flutter/utils/images.dart';

Widget svgPriority({double h = 40, double w = 30}) {
  return SvgPicture.asset(
    ImageUtils.priority,
    height: h,
    width: w,
  );
}