import 'package:flutter/cupertino.dart';
import 'package:project_mangment_flutter/themes/colors.dart';
import 'package:project_mangment_flutter/themes/style.dart';
import 'package:project_mangment_flutter/utils/images.dart';
import 'package:project_mangment_flutter/utils/screen_info.dart';
import 'package:project_mangment_flutter/widget/gap.dart';

class EmptyTask extends StatelessWidget {
  const EmptyTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(ImageUtils.emptyTask, height: ScreenInfo.deviceHeight * .4, ),
        const GapWidget(gapDirection: GapDirection.column),
        Text("Task not available", style: text24Sp.copyWith(color: CustomColors.white),)
      ],
    );
  }
}
