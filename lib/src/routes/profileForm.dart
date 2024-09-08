import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/src/providers/locale_provider.dart';
import 'package:flutterapp/src/providers/phone_number_provider.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:flutterapp/src/shared_widgets/form_text_field.dart';
import 'package:flutterapp/src/shared_widgets/phone_number_field.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileForm extends StatefulWidget {
  static const routeName = "/profileFormRoute";
  final SettingsController? controller;
  final String? label;
  const ProfileForm({Key? key, this.controller, this.label}) : super(key: key);

  @override
  State<ProfileForm> createState() => ProfileFormState();
}

class ProfileFormState extends State<ProfileForm> {
  //
  LocaleProvider? localeProvider;
  String? selectedLocaleCode;
  //
  PhoneNumberProvider? phoneNumberProvider;
  //
  var _loading = true;
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _streetController = TextEditingController();
  final _mobileController = TextEditingController();
  //
  String? _updatedAt;
  //
  String? userId;
  //
  User? _user;
  //
  @override
  void initState() {
    super.initState();
    //
    Future.delayed(Duration(seconds: 2), () => _loadProfile());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _streetController.dispose();
    _mobileController.dispose();

    //
    _updatedAt = '';
    //
    super.dispose();
  }

  Future<void> _loadProfile() async {
    try {
      _user = supabaseClient.auth.currentUser;
      userId = _user!.id;
      final data = (await supabaseClient
          .from('profiles')
          .select()
          .match({'id': '$userId'}).maybeSingle());

      if (data != null) {
        setState(() {
          _updatedAt = data['updated_at'];
          _mobileController.text = data['user_mobile'];
          _usernameController.text = data['username'];
          _nameController.text = data['first_name'];
          _surnameController.text = data['surname'];
          _cityController.text = data['user_city'];
          _countryController.text = data['user_country'];
          _streetController.text = data['street'];
        });
      }
    } catch (e) {
      Flushbar(
        duration: Duration(seconds: 3),
        title: 'generalUse-error'.tr().toString(),
        titleColor: Colors.red,
        titleSize: 20.0,
        message: 'generalUse-failedGettingProfileDetails'.tr().toString(),
        messageColor: Colors.black,
        messageSize: 16.0,
        messageText:
            Text('generalUse-failedGettingProfileDetails'.tr().toString()),
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
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        flushbarPosition: FlushbarPosition.TOP,
        positionOffset: 0.0,
        flushbarStyle: FlushbarStyle.FLOATING,
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Applying new selected locale on this page
    localeProvider = Provider.of<LocaleProvider>(context);
    selectedLocaleCode = localeProvider!.selectedLocaleCode;
    //
    phoneNumberProvider = Provider.of<PhoneNumberProvider>(context);
    //
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D82AE),
        elevation: 10,
        title: Text(
          'Profile Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: _user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              children: [
                //Username
                Card(
                  color: Colors.white,
                  elevation: 10.0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                      width: 0.5,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  borderOnForeground: true,
                  margin: const EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 5.0),
                  clipBehavior: Clip.hardEdge,
                  shadowColor: Colors.grey.shade50,
                  child: StandardFormTextField(
                    controller: _usernameController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    fieldBorderColor: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    prefixIcon: CarbonIcons.identification,
                    prefixIconColor: Colors.teal,
                    suffixTooltip: 'generalUse-userName'.tr().toString(),
                    obsecureText: false,
                    maxLines: 1,
                    formTextFieldLabel: 'generalUse-userName'.tr().toString(),
                    validate: (stringEmailValue) =>
                        stringEmailValue!.isEmpty == true
                            ? 'generalUse-fillAllDetails'.tr().toString()
                            : null,
                    suffixOnPressed: () => _usernameController.clear(),
                    locale: Locale(localeProvider!.selectedLocaleCode!,
                        localeProvider!.selectedLocaleCountry),
                  ),
                ),
                const SizedBox(height: 5.0),
                //Name
                Card(
                  color: Colors.white,
                  elevation: 10.0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                      width: 0.5,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  borderOnForeground: true,
                  margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                  clipBehavior: Clip.hardEdge,
                  shadowColor: Colors.grey.shade50,
                  child: StandardFormTextField(
                    controller: _nameController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    fieldBorderColor: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    prefixIcon: Icons.person,
                    prefixIconColor: Colors.teal,
                    suffixTooltip: 'generalUse-firstName'.tr().toString(),
                    obsecureText: false,
                    maxLines: 1,
                    formTextFieldLabel: 'generalUse-firstName'.tr().toString(),
                    validate: (stringEmailValue) =>
                        stringEmailValue!.isEmpty == true
                            ? 'generalUse-fillAllDetails'.tr().toString()
                            : null,
                    suffixOnPressed: () => _nameController.clear(),
                    locale: Locale(localeProvider!.selectedLocaleCode!,
                        localeProvider!.selectedLocaleCountry),
                  ),
                ),
                const SizedBox(height: 5.0),
                //Surname
                Card(
                  color: Colors.white,
                  elevation: 10.0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                      width: 0.5,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  borderOnForeground: true,
                  margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                  clipBehavior: Clip.hardEdge,
                  shadowColor: Colors.grey.shade50,
                  child: StandardFormTextField(
                    controller: _surnameController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    fieldBorderColor: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    prefixIcon: Icons.person,
                    prefixIconColor: Colors.teal,
                    suffixTooltip: 'generalUse-surname'.tr().toString(),
                    obsecureText: false,
                    maxLines: 1,
                    formTextFieldLabel: 'generalUse-surname'.tr().toString(),
                    validate: (stringEmailValue) =>
                        stringEmailValue!.isEmpty == true
                            ? 'generalUse-fillAllDetails'.tr().toString()
                            : null,
                    suffixOnPressed: () => _surnameController.clear(),
                    locale: Locale(localeProvider!.selectedLocaleCode!,
                        localeProvider!.selectedLocaleCountry),
                  ),
                ),
                const SizedBox(height: 5.0),
                //Street
                Card(
                  color: Colors.white,
                  elevation: 10.0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                      width: 0.5,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  borderOnForeground: true,
                  margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                  clipBehavior: Clip.hardEdge,
                  shadowColor: Colors.grey.shade50,
                  child: StandardFormTextField(
                    controller: _streetController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    fieldBorderColor: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    prefixIcon: Icons.streetview,
                    prefixIconColor: Colors.teal,
                    suffixTooltip: 'generalUse-street'.tr().toString(),
                    obsecureText: false,
                    maxLines: 1,
                    formTextFieldLabel: 'generalUse-street'.tr().toString(),
                    validate: (stringEmailValue) =>
                        stringEmailValue!.isEmpty == true
                            ? 'generalUse-fillAllDetails'.tr().toString()
                            : null,
                    suffixOnPressed: () => _streetController.clear(),
                    locale: Locale(localeProvider!.selectedLocaleCode!,
                        localeProvider!.selectedLocaleCountry),
                  ),
                ),
                const SizedBox(height: 5.0),
                //city
                Card(
                  color: Colors.white,
                  elevation: 10.0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                      width: 0.5,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  borderOnForeground: true,
                  margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                  clipBehavior: Clip.hardEdge,
                  shadowColor: Colors.grey.shade50,
                  child: StandardFormTextField(
                    controller: _cityController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    fieldBorderColor: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    prefixIcon: Icons.location_city,
                    prefixIconColor: Colors.teal,
                    suffixTooltip: 'generalUse-city'.tr().toString(),
                    obsecureText: false,
                    maxLines: 1,
                    formTextFieldLabel: 'generalUse-city'.tr().toString(),
                    validate: (stringEmailValue) =>
                        stringEmailValue!.isEmpty == true
                            ? 'generalUse-fillAllDetails'.tr().toString()
                            : null,
                    suffixOnPressed: () => _cityController.clear(),
                    locale: Locale(localeProvider!.selectedLocaleCode!,
                        localeProvider!.selectedLocaleCountry),
                  ),
                ),
                const SizedBox(height: 5.0),
                //country
                Card(
                  color: Colors.white,
                  elevation: 10.0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                      width: 0.5,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  borderOnForeground: true,
                  margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                  clipBehavior: Clip.hardEdge,
                  shadowColor: Colors.grey.shade50,
                  child: StandardFormTextField(
                    controller: _countryController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    fieldBorderColor: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    prefixIcon: Icons.map,
                    prefixIconColor: Colors.teal,
                    suffixTooltip: 'generalUse-country'.tr().toString(),
                    obsecureText: false,
                    maxLines: 1,
                    formTextFieldLabel: 'generalUse-country'.tr().toString(),
                    validate: (stringEmailValue) =>
                        stringEmailValue!.isEmpty == true
                            ? 'generalUse-fillAllDetails'.tr().toString()
                            : null,
                    suffixOnPressed: () => _countryController.clear(),
                    locale: Locale(localeProvider!.selectedLocaleCode!,
                        localeProvider!.selectedLocaleCountry),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return PhoneNumberField();
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                //Save button
                ElevatedButton(
                  onPressed: () async {
                    //
                    try {
                      setState(() {
                        _loading = true;
                      });
                      final username = _usernameController.text;
                      final name = _nameController.text;
                      final surname = _surnameController.text;
                      final city = _cityController.text;
                      final country = _countryController.text;
                      final street = _streetController.text;
                      final mobile = phoneNumberProvider!.phoneNumber;
                      await supabaseClient.from('profiles').upsert({
                        'id': userId,
                        'updated_at': DateTime.timestamp().toUtc(),
                        'user_mobile': mobile,
                        'username': username,
                        'first_name': name,
                        'surname': surname,
                        'user_city': city,
                        'user_country': country,
                        'street': street
                      });
                      if (mounted) {
                        setState(() {
                          _usernameController.clear();
                          _nameController.clear();
                          _surnameController.clear();
                          _streetController.clear();
                          _cityController.clear();
                          _countryController.clear();
                          Flushbar(
                            duration: Duration(seconds: 3),
                            title: 'generalUse-registerSuccess'.tr().toString(),
                            titleColor: Colors.red,
                            titleSize: 20.0,
                            message: 'generalUse-dataSaved'.tr().toString(),
                            messageColor: Colors.black,
                            messageSize: 16.0,
                            messageText:
                                Text('generalUse-dataSaved'.tr().toString()),
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
                            dismissDirection:
                                FlushbarDismissDirection.HORIZONTAL,
                            flushbarPosition: FlushbarPosition.TOP,
                            positionOffset: 0.0,
                            flushbarStyle: FlushbarStyle.FLOATING,
                          )..show(context);
                          _loading = false;
                        });
                      }
                      Timer(Duration(seconds: 3), () => signOut());
                    } catch (exc) {
                      //
                      exc.toString();
                      Flushbar(
                        duration: Duration(seconds: 3),
                        title: 'generalUse-error'.tr().toString(),
                        titleColor: Colors.red,
                        titleSize: 20.0,
                        message: 'Failed..Kindly Try Again'.tr().toString(),
                        messageColor: Colors.black,
                        messageSize: 16.0,
                        messageText:
                            Text('Failed..Kindly Try Again'.tr().toString()),
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
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        flushbarPosition: FlushbarPosition.TOP,
                        positionOffset: 0.0,
                        flushbarStyle: FlushbarStyle.FLOATING,
                      )..show(context);
                      Timer(Duration(seconds: 3), () => signOut());
                    }
                  },
                  child: Icon(
                    Icons.save,
                    size: 30.0,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120.0),
                  child: ElevatedButton(
                    onPressed: () => signOut(),
                    child: Text('generalUse-exit'.tr().toString()),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut(scope: SignOutScope.global);
    if (supabaseClient.auth.currentUser == null) {
      context.go('/b');
    }
  }
}
