import 'dart:async';

import 'package:another_flushbar/flushbar.dart';

import 'package:flutterapp/main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutterapp/src/constants.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:flutterapp/src/shared_widgets/text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase/supabase.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = '/forgotPasswordPage';
  final SettingsController? controller;
  final String? label;
  ForgotPasswordPage({Key? key, this.controller, this.label}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //
  final _resetPasswordController = TextEditingController();
  final _userEmailController = TextEditingController();
  //
  @override
  void initState() {
    //
    _getAuth();
    //
    super.initState();
  }

  //
  User? _user;
  Future<void> _getAuth() async {
    setState(() {
      _user = supabaseClient.auth.currentUser;
    });
    supabaseClient.auth.onAuthStateChange.listen((data) {
      _user = data.session?.user;
    });
  }

  //
  @override
  void dispose() {
    _resetPasswordController.dispose();
    _userEmailController.dispose();
//
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kTextBlueColor,
        title: Text(
          'Reset Your Password'.tr().toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
        children: [
          SizedBox(
            height: 20.0,
          ),
          TextFieldStandard(
            controller: _userEmailController,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            fieldBorderColor: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontColor: Colors.black,
            prefixIcon: Icons.email_outlined,
            prefixIconColor: Colors.black,
            suffixTooltip: 'Your Account Email'.tr().toString(),
            obsecureText: false,
            maxLines: 1,
            labelText: 'Your Account Email'.tr().toString(),
            validate: (stringEmailValue) => stringEmailValue!.isEmpty == true
                ? 'generalUse-fillAllDetails'.tr().toString()
                : null,
            suffixOnPressed: () => _resetPasswordController.clear(),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFieldStandard(
            controller: _resetPasswordController,
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            fieldBorderColor: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontColor: Colors.black,
            prefixIcon: Icons.password_outlined,
            prefixIconColor: Colors.black,
            suffixTooltip: 'New Password'.tr().toString(),
            obsecureText: false,
            maxLines: 1,
            labelText: 'New Password'.tr().toString(),
            validate: (stringEmailValue) => stringEmailValue!.isEmpty == true
                ? 'generalUse-fillAllDetails'.tr().toString()
                : null,
            suffixOnPressed: () => _resetPasswordController.clear(),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0),
            child: ElevatedButton(
              child: Text(
                'Reset'.tr().toString(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () async {
               if (_user != null) {
                  await supabaseClient
                      .from('profiles')
                      .update({'user_pass': '${_resetPasswordController.text}'})
                      .eq('user_email', '${_userEmailController.text}')
                      .then((value) {
                        //
                        Flushbar(
                          duration: Duration(seconds: 3),
                          title: 'Success'.tr().toString(),
                          titleColor: Colors.red,
                          titleSize: 20.0,
                          message: 'Successful'.tr().toString(),
                          messageColor: Colors.black,
                          messageSize: 16.0,
                          messageText: Text('Successful'.tr().toString()),
                          titleText: Text(
                            'Success'.tr().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                            ),
                          ),
                          icon: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 20.0,
                          ),
                          shouldIconPulse: true,
                          maxWidth: 300.0,
                          margin: EdgeInsets.only(top: 300.0),
                          padding: EdgeInsets.all(3.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderColor: Colors.black,
                          borderWidth: 1.0,
                          backgroundColor: Colors.grey.shade300,
                          mainButton: Text(''),
                          onTap: (value) {},
                          isDismissible: true,
                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                          flushbarPosition: FlushbarPosition.TOP,
                          positionOffset: 0.0,
                          flushbarStyle: FlushbarStyle.FLOATING,
                        )..show(context);
                      })
                      .onError((error, stackTrace) {
                        //
                        setState(() {
                          _resetPasswordController.clear();
                          _userEmailController.clear();
                        });
                        Flushbar(
                          duration: Duration(seconds: 3),
                          title: 'generalUse-sorry'.tr().toString(),
                          titleColor: Colors.red,
                          titleSize: 20.0,
                          message: 'Reset Error'.tr().toString(),
                          messageColor: Colors.black,
                          messageSize: 16.0,
                          messageText: Text('Reset Error'.tr().toString()),
                          titleText: Text(
                            'generalUse-sorry'.tr().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                            ),
                          ),
                          icon: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 20.0,
                          ),
                          shouldIconPulse: true,
                          maxWidth: 300.0,
                          margin: EdgeInsets.only(top: 300.0),
                          padding: EdgeInsets.all(3.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderColor: Colors.black,
                          borderWidth: 1.0,
                          backgroundColor: Colors.grey.shade300,
                          mainButton: Text(''),
                          onTap: (value) {},
                          isDismissible: true,
                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                          flushbarPosition: FlushbarPosition.TOP,
                          positionOffset: 0.0,
                          flushbarStyle: FlushbarStyle.FLOATING,
                        )..show(context);
                      })
                      .whenComplete(() => null);
                } else {
                  Flushbar(
                    duration: Duration(seconds: 3),
                    title: 'generalUse-sorry'.tr().toString(),
                    titleColor: Colors.red,
                    titleSize: 20.0,
                    message: 'Login to your account'.tr().toString(),
                    messageColor: Colors.black,
                    messageSize: 16.0,
                    messageText: Text('Login to your account'.tr().toString()),
                    titleText: Text(
                      'generalUse-sorry'.tr().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0,
                      ),
                    ),
                    icon: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 20.0,
                    ),
                    shouldIconPulse: true,
                    maxWidth: 300.0,
                    margin: EdgeInsets.only(top: 300.0),
                    padding: EdgeInsets.all(3.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderColor: Colors.black,
                    borderWidth: 1.0,
                    backgroundColor: Colors.grey.shade300,
                    mainButton: Text(''),
                    onTap: (value) {},
                    isDismissible: true,
                    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                    flushbarPosition: FlushbarPosition.TOP,
                    positionOffset: 0.0,
                    flushbarStyle: FlushbarStyle.FLOATING,
                  )..show(context);
                  Timer(Duration(seconds: 2), () => context.go('/b'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
