import 'package:animated_login_fb_app/services/gender.dart';
import 'package:animated_login_fb_app/utils/colors.dart';
import 'package:animated_login_fb_app/utils/sizes.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  Gender _gender;

  CustomRadio(this._gender);

  @override
  Widget build(BuildContext context) {
    return Card(
        color:
            _gender.isSelected ? AppColors.kActiveColor : AppColors.whiteColor,
        child: Container(
          height: Sizes.dimens_80,
          width: Sizes.dimens_80,
          alignment: Alignment.center,
          margin: new EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                _gender.icon,
                color: _gender.isSelected ? Colors.white : Colors.grey,
                size: Sizes.dimens_40,
              ),
              SizedBox(height: Sizes.dimens_10),
              Text(
                _gender.name,
                style: TextStyle(
                    color: _gender.isSelected
                        ? AppColors.whiteColor
                        : AppColors.greyColor),
              )
            ],
          ),
        ));
  }
}
