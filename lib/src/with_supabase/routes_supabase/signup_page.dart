import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/src/providers/locale_provider.dart';
import 'package:flutterapp/src/providers/phone_number_provider.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:flutterapp/src/shared_widgets/form_text_field.dart';
import 'package:flutterapp/src/shared_widgets/phone_number_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signupRoute';
  final SettingsController? controller;
  final String? label;

  const SignupPage({super.key, this.controller, this.label});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //
  LocaleProvider? localeProvider;
  String? selectedLocaleCode;
  //
  bool _loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();
  //
  User? _user;
  //
  PhoneNumberProvider? phoneNumberProvider;
  //
  @override
  void initState() {
    // TODO: implement initState
    _getAuth();
    //
    super.initState();
  }

  //
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    //
    super.dispose();
  }

  //
  Future<void> _getAuth() async {
    setState(() {
      _user = supabaseClient.auth.currentUser;
    });
    supabaseClient.auth.onAuthStateChange.listen((data) {
      _user = data.session?.user;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Applying new selected locale on this page
    localeProvider = Provider.of<LocaleProvider>(context);
    selectedLocaleCode = localeProvider!.selectedLocaleCode;
    //
    final height = MediaQuery.of(context).size.height;
    //
    phoneNumberProvider = Provider.of<PhoneNumberProvider>(context);
    //
    return Placeholder(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Signup',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF3D82AE),
          elevation: 10.0,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            SizedBox(
              height: height * 0.35,
              child: Column(
                children: [
                  //Email
                  StandardFormTextField(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    fieldBorderColor: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    prefixIcon: Icons.email,
                    prefixIconColor: Colors.teal,
                    suffixTooltip: 'generalUse-enterEmail'.tr().toString(),
                    obsecureText: false,
                    hintText: 'generalUse-emailToLoginOrSignup'.tr().toString(),
                    maxLines: 1,
                    formTextFieldLabel: 'generalUse-enterEmail'.tr().toString(),
                    validate: (stringEmailValue) =>
                        stringEmailValue!.isEmpty == true
                            ? 'generalUse-fillAllDetails'.tr().toString()
                            : null,
                    suffixOnPressed: () => _emailController.clear(),
                    locale: Locale(localeProvider!.selectedLocaleCode!,
                        localeProvider!.selectedLocaleCountry),
                  ),
                  const SizedBox(height: 10.0),
                  //Password
                  StandardFormTextField(
                    controller: _passwordController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    fieldBorderColor: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    prefixIcon: Icons.security,
                    prefixIconColor: Colors.teal,
                    suffixTooltip: 'generalUse-password'.tr().toString(),
                    obsecureText: true,
                    maxLines: 1,
                    formTextFieldLabel: 'generalUse-password'.tr().toString(),
                    validate: (stringPassValue) =>
                        stringPassValue!.isEmpty == true
                            ? 'generalUse-fillAllDetails'.tr().toString()
                            : null,
                    suffixOnPressed: () => _passwordController.clear(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  //Mobile
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return PhoneNumberField();
                    },
                  ),
                ],
              ),
            ),
            //Signup button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(
                    Size(100.0, 40.0),
                  ),
                  maximumSize: WidgetStateProperty.all(
                    Size(100.0, 40.0),
                  ),
                  side: WidgetStateProperty.all(
                    const BorderSide(
                      color: Colors.yellow,
                      width: 0.3,
                      style: BorderStyle.solid,
                    ),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  //Signup
                  try {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final mobile = phoneNumberProvider!.phoneNumber;
                    print('mobile $mobile');
                    await supabaseClient.auth.signUp(
                      email: email,
                      password: password,
                      //phone: null,
                      emailRedirectTo: 'io.supabase.bueno://login-callback/',
                      data: {"user_mobile": mobile, "user_is_admin": false},
                      //captchaToken: '',
                      //channel: OtpChannel.whatsapp,
                    ).then((signupResponse) {
                      //
                      if (signupResponse.user != null) {
                        setState(() {
                          _emailController.clear();
                          _passwordController.clear();
                          phoneNumberProvider!.setPhoneNumber('');
                        });
                        Flushbar(
                          duration: Duration(seconds: 3),
                          title: 'generalUse-registerSuccess'.tr().toString(),
                          titleColor: Colors.red,
                          titleSize: 20.0,
                          message: 'generalUse-confirmationEmailSent'
                              .tr()
                              .toString(),
                          messageColor: Colors.black,
                          messageSize: 16.0,
                          messageText: Text('generalUse-confirmationEmailSent'
                              .tr()
                              .toString()),
                          titleText: Text(
                            'generalUse-registerSuccess'.tr().toString(),
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
                        _loading = false;
                        Timer(
                          Duration(seconds: 2),
                          () => context.go('/b'),
                        );
                      } else {
                        setState(() {
                          _emailController.clear();
                          _passwordController.clear();
                          phoneNumberProvider!.setPhoneNumber('');
                        });
                        Flushbar(
                          duration: Duration(seconds: 3),
                          title: 'generalUse-sorry'.tr().toString(),
                          titleColor: Colors.red,
                          titleSize: 20.0,
                          message: 'generalUse-signupError'.tr().toString(),
                          messageColor: Colors.black,
                          messageSize: 16.0,
                          messageText:
                              Text('generalUse-signupError'.tr().toString()),
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
                        _loading = false;
                        Timer(
                          Duration(seconds: 2),
                          () => context.go('/b'),
                        );
                      }
                    }).onError((error, stackTrace) {
                      //
                      print('error1 ${error.toString()}');
                      setState(() {
                        _emailController.clear();
                        _passwordController.clear();
                        phoneNumberProvider!.setPhoneNumber('');
                      });
                      Flushbar(
                        duration: Duration(seconds: 3),
                        title: 'generalUse-sorry'.tr().toString(),
                        titleColor: Colors.red,
                        titleSize: 20.0,
                        message: 'signupError'.tr().toString(),
                        messageColor: Colors.black,
                        messageSize: 16.0,
                        messageText:
                            Text('generalUse-signupError'.tr().toString()),
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
                      _loading = false;
                      Timer(
                        Duration(seconds: 3),
                        () => context.go('/b'),
                      );
                    }).whenComplete(() => null);
                  } catch (e) {
                    setState(() {
                      _emailController.clear();
                      _passwordController.clear();
                      phoneNumberProvider!.setPhoneNumber('');
                    });
                    Flushbar(
                      duration: Duration(seconds: 3),
                      title: 'generalUse-sorry'.tr().toString(),
                      titleColor: Colors.red,
                      titleSize: 20.0,
                      message: 'generalUse-signupFailed'.tr().toString(),
                      messageColor: Colors.black,
                      messageSize: 16.0,
                      messageText:
                          Text('generalUse-signupFailed'.tr().toString()),
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
                    _loading = false;
                    Timer(
                      Duration(seconds: 3),
                      () => context.go('/b'),
                    );
                  }
                },
                child: const Text('Signup'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
