// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

import 'components/input_filed.dart';
import 'components/logo_viewer.dart';
import 'components/toggle_button.dart';
import 'constant.dart';

class LogInSignUpPage extends StatefulWidget {
  static String id = "SignUp Pagess";
  const LogInSignUpPage({super.key});

  @override
  State<LogInSignUpPage> createState() => _LogInSignUpPageState();
}

class _LogInSignUpPageState extends State<LogInSignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  _forgotPassword() {
    //TODO: Forgot Password navigato tot different pages
  }

  Future<void> _logIn(BuildContext context) async {
    print("${emailController.text}  ${passwordController.text}  ");
    EasyLoading.show(
      status: 'Processing...',
      maskType: EasyLoadingMaskType.black,
    );

    //TODO: Code for Log In
    EasyLoading.dismiss();
  }

  Future<void> _SignUp(BuildContext context) async {
    print("${emailController.text}  ${passwordController.text}  ${confirmPasswordController.text}  ");
    EasyLoading.show(
      status: 'Processing...',
      maskType: EasyLoadingMaskType.black,
    );
    //TODO Code for SignUp
    EasyLoading.dismiss();
  }

  bool isLogIn = true;
  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        print("${emailController.text}  ${passwordController.text} ${confirmPasswordController.text} "),
        FocusScope.of(context).requestFocus(FocusNode())
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (isLogIn ? 0.11 : 0.07),
                  ),
                  LogoViewer(side: MediaQuery.of(context).size.height * 0.3),
                  SizedBox(
                    height: 40,
                  ),
                  ToggleButton(
                    width: 300.0,
                    height: 50.0,
                    toggleBackgroundColor: kBackgroundColorInputField,
                    toggleBorderColor: (Colors.grey[350])!,
                    toggleColor: (Colors.indigo[900])!,
                    activeTextColor: Colors.white,
                    inactiveTextColor: Colors.white60,
                    leftDescription: 'Log In',
                    rightDescription: 'Sign Up',
                    onLeftToggleActive: () {
                      setState(() {
                        isLogIn = !isLogIn;
                      });
                    },
                    onRightToggleActive: () {
                      setState(() {
                        isLogIn = !isLogIn;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputField(
                      hintText: "",
                      controllerss: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      labelText: "Email",
                      prefixIcon: Icons.email_outlined),
                  SizedBox(
                    height: 20,
                  ),
                  InputField(
                    isPassword: true,
                    controllerss: passwordController,
                    keyboardType: TextInputType.text,
                    labelText: "Password",
                    prefixIcon: Icons.password,
                    hintText: "*****",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: !isLogIn,
                    child: InputField(
                      isPassword: true,
                      controllerss: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      labelText: "Confirm Password",
                      prefixIcon: Icons.password,
                      hintText: "*****",
                    ),
                  ),
                  Visibility(
                      visible: !isLogIn,
                      child: SizedBox(
                        height: 20,
                      )),
                  Visibility(
                    visible: isLogIn,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: _forgotPassword,
                          child: Text(
                            "ForgotPassword",
                            style: kwhiteTextStyle.copyWith(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ProgressButton.icon(
                      textStyle: kwhiteTextStyle,
                      height: 40.00,
                      maxWidth: 200.00,
                      iconedButtons: {
                        ButtonState.idle: IconedButton(
                          text: isLogIn ? "Log In" : "Sign Up",
                          icon: Icon(Icons.login_sharp, color: Colors.white),
                          color: Colors.deepPurple.shade500,
                        ),
                        ButtonState.loading: IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
                        ButtonState.fail: IconedButton(text: "Failed", icon: Icon(Icons.cancel, color: Colors.white), color: Colors.red.shade300),
                        ButtonState.success: IconedButton(
                            text: "Success",
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            color: Colors.green.shade400)
                      },
                      onPressed: () => {
                            FocusScope.of(context).requestFocus(FocusNode()),
                            if (emailController.text.isEmpty)
                              {
                                SnackbarFun(
                                  context: context,
                                  icons: Icons.error,
                                  iconsColor: Colors.red,
                                  text: 'Plese Fill the Email',
                                )
                              }
                            else if (passwordController.text.isEmpty)
                              {
                                SnackbarFun(
                                  context: context,
                                  icons: Icons.error,
                                  iconsColor: Colors.red,
                                  text: 'Plese input Password',
                                )
                              }
                            else if (!isLogIn && confirmPasswordController.text.isEmpty)
                              {
                                SnackbarFun(
                                  context: context,
                                  icons: Icons.error,
                                  iconsColor: Colors.red,
                                  text: 'Plese input Confirm Password',
                                  // text: "${!isLogIn} ${confirmPasswordController.text.isEmpty}",
                                )
                              }
                            else if (!isLogIn && (confirmPasswordController.text != passwordController.text))
                              {
                                SnackbarFun(
                                  context: context,
                                  icons: Icons.error,
                                  iconsColor: Colors.red,
                                  text: 'Password and Confirm Password Doesnot Match',
                                  // text: "${!isLogIn} ${confirmPasswordController.text == passwordController.text}",
                                )
                              }
                            else
                              {isLogIn ? _logIn(context) : _SignUp(context)},
                          },
                      state: ButtonState.idle),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> SnackbarFun(
    {required BuildContext context, icons = Icons.error, iconsColor = Colors.red, text}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: kBackgroundColorInputField,
        content: Row(
          children: [
            Icon(icons, color: iconsColor),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.77,
              child: Text(
                text,
                softWrap: true,
                style: kwhiteTextStyle,
              ),
            ),
          ],
        )),
  );
}
