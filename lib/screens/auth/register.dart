import 'package:animated_login_fb_app/config/palette.dart';
import 'package:provider/provider.dart';
import 'package:animated_login_fb_app/services/Validator.dart';
import 'package:animated_login_fb_app/utils/colors.dart';
import 'package:animated_login_fb_app/utils/constants.dart';
import 'package:animated_login_fb_app/utils/sizes.dart';
import 'package:animated_login_fb_app/widgets/InputTextField.dart';
import 'package:animated_login_fb_app/widgets/decoration_functions.dart';
import 'package:animated_login_fb_app/widgets/sign_in_up_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_login_fb_app/services/auth_service.dart';
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
  final _formKey = GlobalKey<FormState>();

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
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
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: InputTextField(
                      fieldController: emailController,
                      fieldValidator: (val) =>
                          val.isNotEmpty ? null : "Please Enter Your Email",
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
                        fieldValidator: (val) => val.length < 8
                            ? "Please enter more than 8 chars"
                            : null,
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
                    isLoading: loginProvider.isLoading,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print("Email: ${emailController.text}");
                        print("Password: ${passwordController.text}");

                        await loginProvider.register(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        loginProvider.setMessage(null);
                      }

                      // widget.signinIn(emailController, passwordController)

                      // _buttonChange();
                      // context.signInWithEmailAndPassword();
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        loginProvider.setMessage(null);
                        widget.onSignInPressed?.call();
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (loginProvider.errorMessage != null)
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                      color: Colors.amberAccent,
                      child: ListTile(
                        title: Center(
                          child: Text(
                            loginProvider.errorMessage,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        leading: Icon(
                          Icons.error,
                          size: 12,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 12,
                          ),
                          onPressed: () => loginProvider.setMessage(null),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
