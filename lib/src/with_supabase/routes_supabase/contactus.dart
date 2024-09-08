import 'package:flutter/material.dart';
import 'package:flutterapp/src/providers/locale_provider.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:provider/provider.dart';

import 'package:contactus/contactus.dart';

class Contactus extends StatelessWidget {
  static const routeName = '/contactusRoute';

  final SettingsController? controller;
  LocaleProvider? localeProvider;
  String? selectedLocaleCode;

  Contactus({Key? key, this.controller, this.selectedLocaleCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Applying new selected locale on this page
    localeProvider = Provider.of<LocaleProvider>(context);
    selectedLocaleCode = localeProvider!.selectedLocaleCode;

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 20.0),
        child: ContactUs(
          cardColor: Colors.teal.shade200,
          /*logo: AssetImage(
            'assets/images/contactus.jpg',
          ),*/
          image: Image(
            image: AssetImage('assets/images/contactus.jpg'),
            fit: BoxFit.fill,
            width: 300.0,
            height: 150.0,
          ),
          email: 'starafter50@gmail.com',
          companyName: 'Dezire Tech Com',
          textColor: Colors.white,
          companyColor: Colors.teal,
          companyFontSize: 20.0,
          companyFontWeight: FontWeight.w400,
          phoneNumber: '+971-50-1376698',
          dividerThickness: 2,
          //website: 'https://abhishekdoshi.godaddysites.com',
          githubUserName: 'beautybird',
          //linkedinURL: 'https://www.linkedin.com/in/abhishek-doshi-520983199/',
          tagLine: 'Postgresql & apps development',
          taglineColor: Colors.black,
          taglineFontWeight: FontWeight.normal,
          twitterHandle: 'database_nerd',
          instagram: 'Dezireapp',
        ),
      ),
      resizeToAvoidBottomInset: true,
      //bottomNavigationBar: NavigationBarSection(),
    );
  }
}
