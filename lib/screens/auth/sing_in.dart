import 'package:animated_login_fb_app/config/palette.dart';
import 'package:animated_login_fb_app/screens/auth/register.dart';
import 'package:animated_login_fb_app/screens/auth/wrapper.dart';
import 'package:animated_login_fb_app/services/Validator.dart';
import 'package:animated_login_fb_app/services/auth_service.dart';
import 'package:animated_login_fb_app/utils/colors.dart';
import 'package:animated_login_fb_app/utils/constants.dart';
import 'package:animated_login_fb_app/utils/sizes.dart';
import 'package:animated_login_fb_app/widgets/InputTextField.dart';
import 'package:animated_login_fb_app/widgets/decoration_functions.dart';
import 'package:animated_login_fb_app/widgets/sign_in_up_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final VoidCallback onRegisterClicked;

  const SignIn({Key key, @required this.onRegisterClicked}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Color _buttonColor = AppColors.kInactiveColor;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  void _buttonChange() {
    // _controller.forward(from: 0);
    setState(() {
      _buttonColor = AppColors.kActiveColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome \nBack',
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
                      inputDecoration:
                          signInInputDecoration(hintText: "Email Address"),
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
                        inputDecoration:
                            signInInputDecoration(hintText: "Password"),
                        onDiff: (value) {
                          submit(value, 2);
                          print(value);
                        },
                        hideText: true,
                        checkIcon: (kCorrectPass)
                            ? inputCheck(AppColors.kActiveColor)
                            : inputCheck(AppColors.whiteColor)),
                  ),
                  SignInBar(
                    label: 'Sign in',
                    isLoading: loginProvider.isLoading,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print("Email: ${emailController.text}");
                        print("Password: ${passwordController.text}");

                        await loginProvider.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        loginProvider.setMessage(null);
                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Wrapper();
                            },
                          ),
                        );
                      }
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
                        widget.onRegisterClicked?.call();
                        // Navigator.of(context).push(new MaterialPageRoute(
                        //     builder: (BuildContext context) {
                        //   return Register();
                        // }));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: Palette.darkBlue,
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
