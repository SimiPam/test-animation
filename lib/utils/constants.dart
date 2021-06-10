import 'package:animated_login_fb_app/utils/sizes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Padding inputCheck(Color color) {
  return Padding(
      padding: const EdgeInsets.all(15.0),
      child: CircleAvatar(
        maxRadius: Sizes.dimens_10,
        backgroundColor: color,
        child: Icon(
          Icons.check,
          size: Sizes.dimens_13,
          color: AppColors.whiteColor,
        ),
      ));
}

Padding buttonWidget(
    {@required VoidCallback buttonAction,
    @required Color buttonColor,
    @required String buttonText}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: Sizes.dimens_16),
    child: Material(
      color: buttonColor,
      borderRadius: BorderRadius.all(Radius.circular(Sizes.dimens_11)),
      elevation: Sizes.dimens_5,
      child: MaterialButton(
        onPressed: buttonAction,
        child: Text(
          buttonText,
        ),
      ),
    ),
  );
}

Center bottomText(
    {@required BuildContext context,
    @required String firstText,
    @required String secondText}) {
  return Center(
    child: RichText(
      text: TextSpan(
          text: firstText,
          style: Theme.of(context).textTheme.headline2,
          children: [
            TextSpan(
                text: secondText,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: AppColors.blueColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // navigate to desired screen
                  })
          ]),
    ),
  );
}

const String kRegexEmail =
    "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$)";
const String kRegexNo = r'^(?:[+0][1-9])?[0-9]{10,12}$';
