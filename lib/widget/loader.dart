import 'package:flutter/material.dart';
import 'package:project_mangment_flutter/themes/style.dart';
import 'package:project_mangment_flutter/utils/utils.dart';
import 'package:project_mangment_flutter/widget/gap.dart';

showLoader({required BuildContext context, String msg = "Please wait..."}) {
  showDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width * .8,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
                const GapWidget(
                  gapDirection: GapDirection.row,
                ),
                Expanded(child: Text(msg, style: textBold14Sp))
              ],
            ),
          ),
        );
      });
}

showYesNoDialog(
    {required BuildContext context,
      required String msg,
      required VoidCallback yesClick,
      VoidCallback? noClick,
      String yesText = "Yes",
      String noText = "No",

    }) {
  showDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width * .8,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const GapWidget(
                  gapDirection: GapDirection.column,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  20.0),
                    child: Text(msg, style: textBold18Sp),
                  ),
                ),
                const GapWidget(
                  gapDirection: GapDirection.column,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: noClick ?? () {
                        Utils.instance.popScreen(context: context);
                      },
                      child: Text(
                        noText,
                        style: textBold16Sp,
                      ),
                    ),
                    TextButton(
                      onPressed: yesClick,
                      child: Text(
                        yesText,
                        style: textBold16Sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
