
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_mangment_flutter/themes/colors.dart';
import 'package:project_mangment_flutter/utils/utils.dart';
import 'package:project_mangment_flutter/widget/gap.dart';

typedef OnDateSelected(date);

class AnimatedHorizontalCalendar extends StatefulWidget {
  final DateTime date, current;
  final DateTime? initialDate;
  final DateTime? lastDate;
  final Color? textColor;
  final Color? colorOfWeek;
  final Color? colorOfMonth;
  final double? fontSizeOfWeek;
  final FontWeight? fontWeightWeek;
  final double? fontSizeOfMonth;
  final FontWeight? fontWeightMonth;
  final Color? backgroundColor;
  final Color? selectedColor;
  final int? duration;
  final Curve? curve;
  final BoxShadow? selectedBoxShadow;
  final BoxShadow? unSelectedBoxShadow;
  final OnDateSelected? onDateSelected;
  final Widget tableCalenderIcon;
  final Color? tableCalenderButtonColor;
  final ThemeData? tableCalenderThemeData;
  final bool selectPrevious;

  const AnimatedHorizontalCalendar({
    Key? key,
    required this.current,
    required this.date,
    required this.tableCalenderIcon,
    this.initialDate,
    this.lastDate,
    this.textColor,
    this.curve,
    this.tableCalenderThemeData,
    this.selectedBoxShadow,
    this.unSelectedBoxShadow,
    this.duration,
    this.tableCalenderButtonColor,
    this.colorOfMonth,
    this.colorOfWeek,
    this.fontSizeOfWeek,
    this.fontWeightWeek,
    this.fontSizeOfMonth,
    this.fontWeightMonth,
    this.backgroundColor,
    this.selectedColor,
    required this.onDateSelected,
    this.selectPrevious = true,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<AnimatedHorizontalCalendar> {
  DateTime? _startDate;
  var selectedCalenderDate;
  final ScrollController _scrollController = ScrollController();

  calenderAnimation() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: widget.duration ?? 1),
      curve: widget.curve ?? Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    selectedCalenderDate = widget.date;
  }

  String format(DateTime date) => DateFormat('dd-MM-yy').format(date);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    DateTime findFirstDateOfTheWeek(DateTime dateTime) {
      if (dateTime.weekday == 7) {
        if (_scrollController.hasClients) {
          calenderAnimation();
        }
        return dateTime;
      } else {
        if (dateTime.weekday == 1 || dateTime.weekday == 2) {
          if (_scrollController.hasClients) {
            calenderAnimation();
          }
        }
        return dateTime.subtract(Duration(days: dateTime.weekday));
      }
    }

    _startDate = findFirstDateOfTheWeek(selectedCalenderDate);

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: SizedBox(
        child: Row(
          children: <Widget>[
            const GapWidget(gapDirection: GapDirection.column),
            ListView.builder(
              itemCount: 7,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DateTime? date0 = _startDate?.add(Duration(days: index));
                int? diffDays = date0?.difference(selectedCalenderDate).inDays;
                return Container(
                  padding: const EdgeInsets.only(bottom: 20, left: 0.0),
                  child: Container(
                    width: (width - 10) * 0.1428,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: diffDays != 0
                            ? widget.backgroundColor ?? CustomColors.black
                            : widget.selectedColor ?? CustomColors.black,
                        border: diffDays == 0
                            ? Border.all(
                            color: CustomColors.white.withOpacity(0.95), width: 2)
                            : Border.all(
                            color: CustomColors.black.withOpacity(0.25), width: 1),
                        borderRadius: BorderRadius.circular(8.0),
                        /*boxShadow: [
                          diffDays != 0
                              ? widget.selectedBoxShadow ??
                              BoxShadow(
                                color: CustomColors.black.withOpacity(0.25),
                                spreadRadius: 0.0,
                                blurRadius: 10,
                                offset: const Offset(0, 4), // changes position of shadow
                              )
                              : widget.unSelectedBoxShadow ??
                              BoxShadow(
                                color: CustomColors.black.withOpacity(0.35),
                                spreadRadius: 2.0,
                                blurRadius: 10,
                                offset: const Offset(
                                    0, 4), // changes position of shadow
                              )
                        ],*/
                    ),
                    margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    // ignore: deprecated_member_use
                    child: GestureDetector(
                      onTap: () {
                        if (!widget.selectPrevious) {
                          bool check = (date0!.isAfter(widget.current) ||
                              format(date0) == format(widget.current));
                          if (widget.onDateSelected != null && check) {
                            widget.onDateSelected!(date0);
                            setState(() {
                              selectedCalenderDate =
                                  _startDate?.add(Duration(days: index));
                              _startDate =
                                  _startDate?.add(Duration(days: index));
                            });
                          }
                        } else {
                          widget.onDateSelected!(date0);
                          setState(() {
                            selectedCalenderDate =
                                _startDate?.add(Duration(days: index));
                            _startDate = _startDate?.add(Duration(days: index));
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              Utils.instance.getDayOfWeek(date0!),
                              style: TextStyle(
                                  color: diffDays != 0
                                      ? widget.colorOfWeek ?? CustomColors.black
                                      : CustomColors.white,
                                  fontSize: widget.fontSizeOfWeek ?? 12.0,
                                  fontWeight:
                                  widget.fontWeightWeek ?? FontWeight.w600),
                            ),
                           const GapWidget(gapDirection: GapDirection.column),
                            Text(
                              Utils.instance.getDayOfMonth(date0),
                              style: TextStyle(
                                color: diffDays != 0
                                    ? widget.colorOfMonth ?? CustomColors.black
                                    : CustomColors.white,
                                fontSize: widget.fontSizeOfMonth ?? 20.0,
                                fontWeight:
                                widget.fontWeightMonth ?? FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const GapWidget(gapDirection: GapDirection.row),
            /*Container(
              padding: const EdgeInsets.only(bottom: 20, top: 8),
              color: CustomColors.backgroundColor,
              child: InkWell(
                onTap: () async {
                  DateTime? date = await selectDate();
                  widget.onDateSelected!(Utils.instance.getDate(date!));
                  setState(() => selectedCalenderDate = date);
                },
                child: Container(
                  height: double.infinity,
                  width: (width - 10) * 0.1428,
                  decoration: BoxDecoration(
                      color: widget.tableCalenderButtonColor ?? CustomColors.primaryColor,
                      border: Border.all(color: CustomColors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: widget.tableCalenderIcon,
                ),
              ),
            ),
            const GapWidget(gapDirection: GapDirection.row),*/
          ],
        ),
      ),
    );
  }

  /*Future<DateTime?> selectDate() async {
    return await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: selectedCalenderDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: widget.tableCalenderThemeData ??
              ThemeData.light().copyWith(
                primaryColor: CustomColors.secondaryColor,
                buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                colorScheme: const ColorScheme.light(primary: CustomColors.secondaryColor)
                    .copyWith(secondary: CustomColors.secondaryColor),
              ),
          child: child ?? const SizedBox(),
        );
      },
      firstDate:
      widget.initialDate ?? DateTime.now().subtract(const Duration(days: 30)),
      lastDate: widget.lastDate ?? DateTime.now().add(const Duration(days: 30)),
    );
  }*/
}