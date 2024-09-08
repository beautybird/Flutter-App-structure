import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/src/providers/locale_provider.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:flutterapp/src/shared_widgets/form_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/src/shared_widgets/phone_number_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddBuyButtonsLoginRoute extends StatefulWidget {
  static const routeName = "/a/addBuyButtonsLoginRoute";
  final SettingsController? controller;
  final String? label;
  const AddBuyButtonsLoginRoute({Key? key, this.controller, this.label})
      : super(key: key);

  @override
  State<AddBuyButtonsLoginRoute> createState() =>
      AddBuyButtonsLoginRouteState();
}

class AddBuyButtonsLoginRouteState extends State<AddBuyButtonsLoginRoute> {
  //
  LocaleProvider? localeProvider;
  String? selectedLocaleCode;
  //
  bool _loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();
  //
  bool _loginWithPhone = false;
  //
  User? _user;
  //

  @override
  void initState() {
    // TODO: implement initState
    _getAuth();
    //
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    //
    super.dispose();
  }

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    //
    return _user != null
        ? ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            children: [
              SizedBox(
                height: height * 0.25,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Icon(
                      Icons.lock,
                      size: 80.0,
                      color: Colors.greenAccent,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'generalUse-welcomeBack'.tr().toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if (_loginWithPhone == false)
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
                        hintText: 'Email for Login or Signup',
                        maxLines: 1,
                        formTextFieldLabel:
                            'generalUse-enterEmail'.tr().toString(),
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
                        formTextFieldLabel:
                            'generalUse-password'.tr().toString(),
                        validate: (stringPassValue) =>
                            stringPassValue!.isEmpty == true
                                ? 'generalUse-fillAllDetails'.tr().toString()
                                : null,
                        suffixOnPressed: () => _passwordController.clear(),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      //Login with password
                      ElevatedButton(
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
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
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
                          try {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            await supabaseClient.auth
                                .signInWithPassword(
                              email: email,
                              password: password,
                            )
                                .then((signInResponse) {
                              //
                              if (signInResponse.user!.email!
                                  .contains('deziretechapps@gmail.com')) {
                                setState(() {
                                  _emailController.clear();
                                  _passwordController.clear();

                                });
                                Timer(Duration(seconds: 2),()=> context.go('/b/productsFormRoute'));
                              } else {
                                //
                                setState(() {
                                  _emailController.clear();
                                  _passwordController.clear();
                                });
                                Flushbar(
                                  duration: Duration(seconds: 3),
                                  title: 'Logged-in'.tr().toString(),
                                  titleColor: Colors.red,
                                  titleSize: 20.0,
                                  message: 'You are Logged-in '.tr().toString(),
                                  messageColor: Colors.black,
                                  messageSize: 16.0,
                                  messageText:
                                  Text('You are Logged-in '.tr().toString()),
                                  titleText: Text(
                                    'Error'.tr().toString(),
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
                                  dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                                  flushbarPosition: FlushbarPosition.TOP,
                                  positionOffset: 0.0,
                                  flushbarStyle: FlushbarStyle.FLOATING,
                                )..show(context);
                                Timer(Duration(seconds: 2),(){
                                  context.go('/b');
                                });
                              }
                            }).onError((error, stackTrace) {
                              //
                              Flushbar(
                                duration: Duration(seconds: 3),
                                title: 'Error'.tr().toString(),
                                titleColor: Colors.red,
                                titleSize: 20.0,
                                message: 'Login failed '.tr().toString(),
                                messageColor: Colors.black,
                                messageSize: 16.0,
                                messageText:
                                    Text('Login failed '.tr().toString()),
                                titleText: Text(
                                  'Error'.tr().toString(),
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
                                dismissDirection:
                                    FlushbarDismissDirection.HORIZONTAL,
                                flushbarPosition: FlushbarPosition.TOP,
                                positionOffset: 0.0,
                                flushbarStyle: FlushbarStyle.FLOATING,
                              )..show(context);
                              setState(() {
                                _loading = false;
                              });
                            }).whenComplete(() => null);
                          } catch (e) {
                            Flushbar(
                              duration: Duration(seconds: 3),
                              title: 'Error'.tr().toString(),
                              titleColor: Colors.red,
                              titleSize: 20.0,
                              message: 'Login failed '.tr().toString(),
                              messageColor: Colors.black,
                              messageSize: 16.0,
                              messageText:
                                  Text('Login failed '.tr().toString()),
                              titleText: Text(
                                'Error'.tr().toString(),
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
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                              flushbarPosition: FlushbarPosition.TOP,
                              positionOffset: 0.0,
                              flushbarStyle: FlushbarStyle.FLOATING,
                            )..show(context);
                            setState(() {
                              _loading = false;
                            });
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              //Login with phone button
              if (_loginWithPhone == false)
                SizedBox(
                  height: height * 0.05,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          Size(120.0, 40.0),
                        ),
                        maximumSize: WidgetStateProperty.all(
                          Size(120.0, 40.0),
                        ),
                        side: WidgetStateProperty.all(
                          const BorderSide(
                            color: Colors.yellow,
                            width: 0.3,
                            style: BorderStyle.solid,
                          ),
                        ),
                        shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _loginWithPhone = !_loginWithPhone;
                        });
                      },
                      child: Text(
                        'Login with phone ',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              if (_loginWithPhone == true)
                SizedBox(
                  height: height * 0.35,
                  child: Column(
                    children: [
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return PhoneNumberField();
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //Login with phone
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });
                          try {
                            final email = _emailController.text;
                            final mobile = _mobileController.text;
                            await supabaseClient.auth.signInWithOtp(
                              email: email,
                              phone: mobile,
                              //emailRedirectTo: 'io.supabase.bueno://login-callback/',
                              channel: OtpChannel.whatsapp,
                            );
                          } catch (e) {
                            Flushbar(
                              duration: Duration(seconds: 3),
                              title: 'generalUse-error'.tr().toString(),
                              titleColor: Colors.red,
                              titleSize: 20.0,
                              message: 'generalUse-loginFailed'.tr().toString(),
                              messageColor: Colors.black,
                              messageSize: 16.0,
                              messageText: Text(
                                  'generalUse-loginFailed'.tr().toString()),
                              titleText: Text(
                                'generalUse-error'.tr().toString(),
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
                              dismissDirection:
                              FlushbarDismissDirection.HORIZONTAL,
                              flushbarPosition: FlushbarPosition.TOP,
                              positionOffset: 0.0,
                              flushbarStyle: FlushbarStyle.FLOATING,
                            )..show(context);
                            setState(() {
                              _loading = false;
                            });
                          }
                        },
                        child: const Icon(
                          Icons.login,
                          size: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
              //Login with Email button
              if (_loginWithPhone == true)
                SizedBox(
                  height: height * 0.05,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          Size(120.0, 40.0),
                        ),
                        maximumSize: WidgetStateProperty.all(
                          Size(120.0, 40.0),
                        ),
                        side: WidgetStateProperty.all(
                          const BorderSide(
                            color: Colors.yellow,
                            width: 0.3,
                            style: BorderStyle.solid,
                          ),
                        ),
                        shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _loginWithPhone = !_loginWithPhone;
                        });
                      },
                      child: Text(
                        'Login with Email ',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: height * 0.05,
              ),
              //Signup button
              if (_user == null)
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
                    onPressed: ()=> context.go('/b/signupRoute'),
                    child: const Text('Signup'),
                  ),
                ),

              //Signup button
              if (_user != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
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
                      onPressed: ()=> context.go('/b/signupRoute'),
                      child: const Text('Signup'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          Size(80.0, 40.0),
                        ),
                        maximumSize: WidgetStateProperty.all(
                          Size(80.0, 40.0),
                        ),
                        side: WidgetStateProperty.all(
                          const BorderSide(
                            color: Colors.yellow,
                            width: 0.3,
                            style: BorderStyle.solid,
                          ),
                        ),
                        shape:
                        WidgetStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.person_2,
                        size: 25.0,
                      ),
                      onPressed: () => context.go('/b/profileFormRoute'),
                    ),
                  ],
                ),
              /*SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/b/forgotPasswordPage');
                  },
                  child: Text('Forgot Password'),
                ),
              ),*/
            ],
          )
        : ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            children: [
              SizedBox(
                height: height * 0.25,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Icon(
                      Icons.lock,
                      size: 80.0,
                      color: Colors.greenAccent,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'generalUse-welcomeBack'.tr().toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if (_loginWithPhone == false)
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
                        hintText: 'Email for Login or Signup',
                        maxLines: 1,
                        formTextFieldLabel:
                            'generalUse-enterEmail'.tr().toString(),
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
                        formTextFieldLabel:
                            'generalUse-password'.tr().toString(),
                        validate: (stringPassValue) =>
                            stringPassValue!.isEmpty == true
                                ? 'generalUse-fillAllDetails'.tr().toString()
                                : null,
                        suffixOnPressed: () => _passwordController.clear(),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      //Login with password
                      ElevatedButton(
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
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
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
                          try {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            await supabaseClient.auth
                                .signInWithPassword(
                              email: email,
                              password: password,
                            )
                                .then((signInResponse) {
                              //
                              if (signInResponse.user!.email!
                                  .contains('deziretechapps@gmail.com')) {
                                setState(() {
                                  _emailController.clear();
                                  _passwordController.clear();

                                });
                                Timer(Duration(seconds: 2),()=> context.go('/b/productsFormRoute'));
                              } else {
                                //
                                setState(() {
                                  _emailController.clear();
                                  _passwordController.clear();
                                });
                                Flushbar(
                                  duration: Duration(seconds: 3),
                                  title: 'Logged-in'.tr().toString(),
                                  titleColor: Colors.red,
                                  titleSize: 20.0,
                                  message: 'You are Logged-in '.tr().toString(),
                                  messageColor: Colors.black,
                                  messageSize: 16.0,
                                  messageText:
                                  Text('You are Logged-in '.tr().toString()),
                                  titleText: Text(
                                    'Error'.tr().toString(),
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
                                  dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                                  flushbarPosition: FlushbarPosition.TOP,
                                  positionOffset: 0.0,
                                  flushbarStyle: FlushbarStyle.FLOATING,
                                )..show(context);
                                Timer(Duration(seconds: 2),(){
                                  context.go('/b');
                                });
                              }
                            }).onError((error, stackTrace) {
                              //
                              Flushbar(
                                duration: Duration(seconds: 3),
                                title: 'Error'.tr().toString(),
                                titleColor: Colors.red,
                                titleSize: 20.0,
                                message: 'Login failed '.tr().toString(),
                                messageColor: Colors.black,
                                messageSize: 16.0,
                                messageText:
                                    Text('Login failed '.tr().toString()),
                                titleText: Text(
                                  'Error'.tr().toString(),
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
                                dismissDirection:
                                    FlushbarDismissDirection.HORIZONTAL,
                                flushbarPosition: FlushbarPosition.TOP,
                                positionOffset: 0.0,
                                flushbarStyle: FlushbarStyle.FLOATING,
                              )..show(context);
                              setState(() {
                                _loading = false;
                              });
                            }).whenComplete(() => null);
                          } catch (e) {
                            Flushbar(
                              duration: Duration(seconds: 3),
                              title: 'Error'.tr().toString(),
                              titleColor: Colors.red,
                              titleSize: 20.0,
                              message: 'Login failed '.tr().toString(),
                              messageColor: Colors.black,
                              messageSize: 16.0,
                              messageText:
                                  Text('Login failed '.tr().toString()),
                              titleText: Text(
                                'Error'.tr().toString(),
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
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                              flushbarPosition: FlushbarPosition.TOP,
                              positionOffset: 0.0,
                              flushbarStyle: FlushbarStyle.FLOATING,
                            )..show(context);
                            setState(() {
                              _loading = false;
                            });
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              //Login with phone button
              if (_loginWithPhone == false)
                SizedBox(
                  height: height * 0.05,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          Size(120.0, 40.0),
                        ),
                        maximumSize: WidgetStateProperty.all(
                          Size(120.0, 40.0),
                        ),
                        side: WidgetStateProperty.all(
                          const BorderSide(
                            color: Colors.yellow,
                            width: 0.3,
                            style: BorderStyle.solid,
                          ),
                        ),
                        shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _loginWithPhone = !_loginWithPhone;
                        });
                      },
                      child: Text(
                        'Login with phone ',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              if (_loginWithPhone == true)
                SizedBox(
                  height: height * 0.35,
                  child: Column(
                    children: [
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return PhoneNumberField();
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //Login with phone
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });
                          try {
                            final email = _emailController.text;
                            final mobile = _mobileController.text;
                            await supabaseClient.auth.signInWithOtp(
                              email: email,
                              phone: mobile,
                              //emailRedirectTo: 'io.supabase.bueno://login-callback/',
                              channel: OtpChannel.whatsapp,
                            );
                          } catch (e) {
                            Flushbar(
                              duration: Duration(seconds: 3),
                              title: 'generalUse-error'.tr().toString(),
                              titleColor: Colors.red,
                              titleSize: 20.0,
                              message: 'generalUse-loginFailed'.tr().toString(),
                              messageColor: Colors.black,
                              messageSize: 16.0,
                              messageText: Text(
                                  'generalUse-loginFailed'.tr().toString()),
                              titleText: Text(
                                'generalUse-error'.tr().toString(),
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
                              dismissDirection:
                              FlushbarDismissDirection.HORIZONTAL,
                              flushbarPosition: FlushbarPosition.TOP,
                              positionOffset: 0.0,
                              flushbarStyle: FlushbarStyle.FLOATING,
                            )..show(context);
                            setState(() {
                              _loading = false;
                            });
                          }
                        },
                        child: const Icon(
                          Icons.login,
                          size: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
              //Login with Email button
              if (_loginWithPhone == true)
                SizedBox(
                  height: height * 0.05,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          Size(120.0, 40.0),
                        ),
                        maximumSize: WidgetStateProperty.all(
                          Size(120.0, 40.0),
                        ),
                        side: WidgetStateProperty.all(
                          const BorderSide(
                            color: Colors.yellow,
                            width: 0.3,
                            style: BorderStyle.solid,
                          ),
                        ),
                        shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _loginWithPhone = !_loginWithPhone;
                        });
                      },
                      child: Text(
                        'Login with Email ',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: height * 0.05,
              ),
              //Signup button
              if (_user == null)
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
                    onPressed: ()=> context.go('/b/signupRoute'),
                    child: const Text('Signup'),
                  ),
                ),

              //Signup button
              if (_user != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
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
                      onPressed: ()=> context.go('/b/signupRoute'),
                      child: const Text('Signup'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          Size(80.0, 40.0),
                        ),
                        maximumSize: WidgetStateProperty.all(
                          Size(80.0, 40.0),
                        ),
                        side: WidgetStateProperty.all(
                          const BorderSide(
                            color: Colors.yellow,
                            width: 0.3,
                            style: BorderStyle.solid,
                          ),
                        ),
                        shape:
                        WidgetStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.person_2,
                        size: 25.0,
                      ),
                      onPressed: () => context.go('/b/profileFormRoute'),
                    ),
                  ],
                ),
              /*SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/b/forgotPasswordPage');
                  },
                  child: Text('Forgot Password'),
                ),
              ),*/
            ],
          );
  }
}
