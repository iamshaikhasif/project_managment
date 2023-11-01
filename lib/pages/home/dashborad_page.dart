import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_mangment_flutter/pages/home/data/home_data.dart';
import 'package:project_mangment_flutter/pages/home/model/on_going_task.dart';
import 'package:project_mangment_flutter/themes/colors.dart';
import 'package:project_mangment_flutter/themes/style.dart';
import 'package:project_mangment_flutter/utils/const_string.dart';
import 'package:project_mangment_flutter/utils/screen_info.dart';
import 'package:project_mangment_flutter/widget/empty_task.dart';
import 'package:project_mangment_flutter/widget/gap.dart';
import 'package:project_mangment_flutter/widget/loader.dart';
import 'package:project_mangment_flutter/widget/svg_image.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  signOut() {
    showYesNoDialog(
      context: context,
      msg: "Are You Sure you want to logout?",
      yesClick: () {
        FirebaseAuth.instance.signOut();
      },
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.yankeesBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          ConstString.home,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => signOut(),
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.logout,
                color: CustomColors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Top Section
            topSection(),

            //on going list
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
          onGoingTaskListData.isNotEmpty ?
          ListView.builder(
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

  Widget topSection() {
    return Column(
      children: [
        const GapWidget(
          gapDirection: GapDirection.column,
          gap: 20.0,
        ),
        Center(
          child: Text(
            ConstString.everyDayYourTaskPlan,
            textAlign: TextAlign.center,
            style:
                textBold20Sp.copyWith(fontSize: 32, color: CustomColors.white),
          ),
        ),
        const GapWidget(
          gapDirection: GapDirection.column,
          gap: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: SizedBox(
            height: 200,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: firstPriorityCard()),
                const GapWidget(
                  gapDirection: GapDirection.row,
                  gap: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      otherPriorityCard(
                          priority:
                              ConstString.secondPriority.replaceAll(" ", "\n"),
                          color: CustomColors.spiroDiscoBall,
                          task: "16"),
                      otherPriorityCard(
                          priority:
                              ConstString.thirdPriority.replaceAll(" ", "\n"),
                          color: CustomColors.lavender,
                          task: "16"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
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
        color: CustomColors.spaceCadet,
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          svgPriority(),
          const GapWidget(gapDirection: GapDirection.row),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.projectName ?? "",
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textMedium16Sp.copyWith(color: CustomColors.white),
                ),
                Text(
                  data.task ?? "",
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text14Sp.copyWith(color: CustomColors.grey),
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
          ),
        ],
      ),
    );
  }

  Widget firstPriorityCard() {
    return Container(
      height: 190,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: CustomColors.menthol,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          svgPriority(h: 60, w: 60),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                ConstString.firstPriority,
                textAlign: TextAlign.center,
                style: textMedium16Sp,
              ),
              const Text(
                "16 ${ConstString.task}",
                textAlign: TextAlign.center,
                style: text14Sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget otherPriorityCard(
      {required String priority, required Color color, String task = "16"}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          svgPriority(),
          const GapWidget(gapDirection: GapDirection.row),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                priority,
                textAlign: TextAlign.start,
                style: textMedium16Sp,
              ),
              Text(
                "$task ${ConstString.task}",
                textAlign: TextAlign.start,
                style: text14Sp,
              ),
            ],
          ),
        ],
      ),
    );
  }


}
