import 'package:animated_login_fb_app/utils/sizes.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

TextStyle _subheading = TextStyle(
  fontSize: Sizes.dimens_11,
  color: AppColors.whiteColor,
  fontWeight: FontWeight.w500,
  letterSpacing: Sizes.dimens_1_2,
);

TextStyle _heading = TextStyle(
  fontSize: Sizes.dimens_16,
  color: AppColors.whiteColor,
  fontWeight: FontWeight.w700,
);

TextStyle _subheading2 = TextStyle(
  fontSize: Sizes.dimens_10,
  color: AppColors.whiteColor,
  fontWeight: FontWeight.w400,
);

TextStyle _subheading3 = TextStyle(
  fontSize: Sizes.dimens_10,
  color: AppColors.kActiveColor,
  fontWeight: FontWeight.w700,
);

TextStyle _hintTextStyle = TextStyle(
  fontSize: Sizes.dimens_12,
  color: AppColors.kInputTextColor,
  fontWeight: FontWeight.w400,
);

ThemeData myTheme = ThemeData.dark().copyWith(
  accentColor: AppColors.blueColor,
  // scaffoldBackgroundColor: AppColors.scaffoldColor,
  textTheme: TextTheme(
    headline4: _subheading,
    headline1: _heading,
    headline2: _subheading2,
    headline3: _subheading3,
    headline5: _hintTextStyle,
  ),
);
