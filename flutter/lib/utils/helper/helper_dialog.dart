import 'package:customer_zimkey/utils/helper/helper_widgets.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class HelperDialog {
  static confirmActionDialog(
      {required String title,
      required String msg,
      required BuildContext context,
      String btn1Text = "",
      String btn2Text = "",
      VoidCallback? btn1Pressed,
      VoidCallback? btn2Pressed}) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              contentTextStyle: const TextStyle(
                color: AppColors.zimkeyBlack,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
              titlePadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 0,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 0,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              title: Container(
                padding: const EdgeInsets.only(left: 20, right: 15, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: HelperWidgets.buildText(
                          text: title, fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.zimkeyDarkGrey),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.zimkeyDarkGrey.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.clear,
                          color: AppColors.zimkeyDarkGrey,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              content: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HelperWidgets.buildText(text: msg),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (btn1Text.isNotEmpty)
                      Expanded(
                        child: dialogButton(
                            btnPressed: btn1Pressed,
                            btnText: btn1Text,
                            fontColor: AppColors.zimkeyDarkGrey.withOpacity(0.7)),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (btn2Text.isNotEmpty)
                      Expanded(
                          child: dialogButton(
                        btnPressed: btn2Pressed,
                        btnText: btn2Text,
                        fontColor: AppColors.zimkeyOrange,
                      )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Container();
      },
    );
  }

  static Widget dialogButton({VoidCallback? btnPressed, required String btnText, required Color fontColor}) {
    return InkWell(
      onTap: btnPressed,
      child: Container(
        // height: 60,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: HelperWidgets.buildText(text: btnText, fontWeight: FontWeight.bold, fontSize: 15, color: fontColor),
      ),
    );
  }
}
