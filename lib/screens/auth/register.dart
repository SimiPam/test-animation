import 'package:animated_login_fb_app/config/palette.dart';
import 'package:animated_login_fb_app/screens/background_painter.dart';
import 'package:animated_login_fb_app/services/Validator.dart';
import 'package:animated_login_fb_app/services/gender.dart';
import 'package:animated_login_fb_app/utils/colors.dart';
import 'package:animated_login_fb_app/utils/constants.dart';
import 'package:animated_login_fb_app/utils/sizes.dart';
import 'package:animated_login_fb_app/widgets/InputTextField.dart';
import 'package:animated_login_fb_app/widgets/decoration_functions.dart';
import 'package:animated_login_fb_app/widgets/gender_btn.dart';
import 'package:animated_login_fb_app/widgets/sign_in_up_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool kCorrectEmail = false;
bool kCorrectPass = false;

class Register extends StatefulWidget {
  final VoidCallback onSignInPressed;
  final Function signinIn;

  const Register({Key key, @required this.onSignInPressed, this.signinIn})
      : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color _buttonColor = AppColors.kInactiveColor;

  Validator validator = Validator();

  void submit(String value, int tog) {
    setState(() {
      if (tog == Sizes.dimens_1) {
        if (validator.emailValidation(value)) {
          kCorrectEmail = true;
        } else {
          kCorrectEmail = false;
        }
      } else if (tog == Sizes.dimens_2) {
        if (validator.numberValidation(value)) {
          kCorrectPass = true;
        } else {
          kCorrectPass = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Create \nAccount',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 34,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: InputTextField(
                    fieldController: emailController,
                    color: Colors.white,
                    inputDecoration:
                        registerInputDecoration(hintText: "Email Address"),
                    onDiff: (value) {
                      kCorrectEmail = false;
                      submit(value, 1);
                      print(value);
                    },
                    hideText: false,
                    checkIcon: (kCorrectEmail)
                        ? inputCheck(AppColors.kActiveColor)
                        : inputCheck(AppColors.whiteColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: InputTextField(
                      fieldController: passwordController,
                      color: Colors.white,
                      inputDecoration:
                          registerInputDecoration(hintText: "Password"),
                      onDiff: (value) {
                        submit(value, 2);
                        print(value);
                      },
                      hideText: true,
                      checkIcon: (kCorrectPass)
                          ? inputCheck(AppColors.kActiveColor)
                          : inputCheck(AppColors.whiteColor)),
                ),
                SignUpBar(
                  label: 'Sign up',
                  isLoading: true,
                  onPressed: () {
                    widget.signinIn(emailController, passwordController);

                    // _buttonChange();
                    // context.signInWithEmailAndPassword();
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      widget.onSignInPressed?.call();
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
