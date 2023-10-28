import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  Utils._();
  static final instance = Utils._();

  logDebugPrint({required String msg, String tag = "app"}) {
    debugPrint("$tag ---> $msg");
  }

  String getDayOfWeek(DateTime date) => DateFormat('EEE').format(date);

  String getMonth(DateTime date) => DateFormat('MMMM').format(date);

  String getDayOfMonth(DateTime date) => DateFormat('dd').format(date);

  String getDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  nextScreen({required BuildContext context, required Widget child}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => child),
    );
  }

  popScreen({required BuildContext context}){
    Navigator.of(context).pop();
  }
}
