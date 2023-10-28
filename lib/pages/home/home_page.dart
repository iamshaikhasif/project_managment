import 'package:flutter/material.dart';
import 'package:project_mangment_flutter/pages/home/dashborad_page.dart';
import 'package:project_mangment_flutter/pages/home/week_task_page.dart';
import 'package:project_mangment_flutter/themes/colors.dart';
import 'package:project_mangment_flutter/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  List<Widget> pages = [
    const DashboardPage(),
    const WeekTaskPage(),
    Container(
      color: CustomColors.black,
    ),
    Container(
      color: CustomColors.black,
    ),
  ];

  bottomCard({
    required IconData selectedIcon,
    required IconData unSelectedIcon,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        Utils.instance.logDebugPrint(msg: "$index");
        setState(() {
          pageIndex = index;
        });
      },
      child: pageIndex == index
          ? Icon(
              selectedIcon,
              color: Colors.white,
              size: 25,
            )
          : Icon(
              unSelectedIcon,
              color: Colors.white,
              size: 25,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.yankeesBlue,
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: CustomColors.yankeesBlue,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            bottomCard(
                selectedIcon: Icons.home_filled,
                unSelectedIcon: Icons.home_outlined,
                index: 0,
            ),
            bottomCard(
                selectedIcon: Icons.work_rounded,
                unSelectedIcon: Icons.work_outline_outlined,
                index: 1,
            ),
            bottomCard(
                selectedIcon: Icons.widgets_rounded,
                unSelectedIcon: Icons.widgets_outlined,
                index: 2,
            ),
            bottomCard(
                selectedIcon: Icons.person,
                unSelectedIcon: Icons.person_outline,
                index: 3,
            ),
          ],
        ),
      ),
    );
  }
}
