import 'package:flutter/material.dart';
import 'package:project_mangment_flutter/pages/home/data/home_data.dart';
import 'package:project_mangment_flutter/pages/home/model/on_going_task.dart';
import 'package:project_mangment_flutter/themes/colors.dart';
import 'package:project_mangment_flutter/themes/style.dart';
import 'package:project_mangment_flutter/utils/const_string.dart';
import 'package:project_mangment_flutter/utils/screen_info.dart';
import 'package:project_mangment_flutter/utils/utils.dart';
import 'package:project_mangment_flutter/widget/calender.dart';
import 'package:project_mangment_flutter/widget/empty_task.dart';
import 'package:project_mangment_flutter/widget/gap.dart';
import 'package:project_mangment_flutter/widget/svg_image.dart';

class WeekTaskPage extends StatefulWidget {
  const WeekTaskPage({super.key});

  @override
  State<WeekTaskPage> createState() => _WeekTaskPageState();
}

class _WeekTaskPageState extends State<WeekTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.yankeesBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GapWidget(gapDirection: GapDirection.column),
            Center(
              child: Text(
                Utils.instance.getMonth(DateTime.now()),
                style: textBold20Sp.copyWith(color: CustomColors.white, fontSize: 32),
              ),
            ),
            const GapWidget(gapDirection: GapDirection.column),
            SizedBox(
              height: 100,
              child: AnimatedHorizontalCalendar(
                  tableCalenderIcon: const Icon(Icons.calendar_today, color: Colors.white,),
                  date: DateTime.now(),
                  textColor: CustomColors.black,
                  backgroundColor: CustomColors.white,
                  selectedColor: CustomColors.spaceCadet,
                  onDateSelected: (date){
                    Utils.instance.logDebugPrint(msg: date.toString());
                  },
                current: DateTime.now(),
              ),
            ),
            onGoingTaskSection(),
          ],
        ),
      ),
    );
  }


  Widget onGoingTaskSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const GapWidget(
            gapDirection: GapDirection.column,
            gap: 20.0,
          ),
          Text(
            ConstString.onGoingTask,
            textAlign: TextAlign.center,
            style: textBold20Sp.copyWith(color: CustomColors.white),
          ),
          const GapWidget(
            gapDirection: GapDirection.column,
            gap: 20.0,
          ),
          const EmptyTask(),
          /*onGoingTaskListData.isNotEmpty ?
          ListView.builder(
              itemCount: onGoingTaskListData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (ctx, index) {
                return onGoingCard(onGoingTaskListData[index]);
              })
          : const EmptyTask(),*/
        ],
      ),
    );
  }

  Widget onGoingCard(OnGoingTaskModel data) {
    String priority = data.priority ?? "p3";
    Color progressColor = priority.toLowerCase() == "p1"
        ? CustomColors.menthol
        : priority.toLowerCase() == "p2"
        ? CustomColors.spiroDiscoBall
        : CustomColors.lavender;

    return Container(
      decoration: BoxDecoration(
        color: progressColor,
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          svgPriority(),
          const GapWidget(gapDirection: GapDirection.row),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.projectName ?? "",
                textAlign: TextAlign.start,
                style: textMedium16Sp,
              ),
              Text(
                data.task ?? "",
                textAlign: TextAlign.start,
                style: text14Sp.copyWith(color: CustomColors.darkGreyColor),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 5,
                    width: ScreenInfo.deviceWidth * .2,
                    child: LinearProgressIndicator(
                      value: (data.completeValue ?? 0) / 100,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      backgroundColor: CustomColors.grey,
                    ),
                  ),
                  const GapWidget(gapDirection: GapDirection.row),
                  Text(
                    "${data.completeValue}%",
                    textAlign: TextAlign.start,
                    style: text14Sp.copyWith(color: progressColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
