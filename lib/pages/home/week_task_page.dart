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
        child: ListView(
          children: [
            const GapWidget(gapDirection: GapDirection.column),
            Center(
              child: Text(
                Utils.instance.getMonth(DateTime.now()),
                style: textBold20Sp.copyWith(
                    color: CustomColors.white, fontSize: 32),
              ),
            ),
            const GapWidget(gapDirection: GapDirection.column),
            SizedBox(
              height: 100,
              child: AnimatedHorizontalCalendar(
                tableCalenderIcon: const Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ),
                date: DateTime.now(),
                textColor: CustomColors.black,
                backgroundColor: CustomColors.white,
                selectedColor: CustomColors.spaceCadet,
                onDateSelected: (date) {
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
            gap: 40.0,
          ),
          onGoingTaskListData.isNotEmpty
              ? ListView.builder(
                  itemCount: onGoingTaskListData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (ctx, index) {
                    return onGoingCard(onGoingTaskListData[index]);
                  })
              : const EmptyTask(),
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
      height: 100,
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "10:00 AM",
                textAlign: TextAlign.start,
                style: textMedium16Sp.copyWith(color: CustomColors.white),
              ),
              Text(
                "10:00 AM",
                textAlign: TextAlign.start,
                style: textMedium16Sp.copyWith(color: CustomColors.white),
              ),
            ],
          ),
          const GapWidget(gapDirection: GapDirection.row),
          Expanded(
            child: InkWell(
              onTap: () {
                _moreInfo(context, data);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: borderRadius,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            data.projectName ?? "",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textMedium16Sp,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  width: 1.0, color: CustomColors.black)),
                          child: Text(
                            data.priority ?? '',
                            style: text14Sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      data.task ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style:
                          text14Sp.copyWith(color: CustomColors.darkGreyColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _moreInfo(BuildContext context, OnGoingTaskModel data) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Wrap(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.projectName ?? "",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textMedium16Sp,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                width: 1.0, color: CustomColors.black)),
                        child: Text(
                          data.priority ?? '',
                          style: text14Sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    data.task ?? "",
                    textAlign: TextAlign.start,
                    style: text14Sp,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
