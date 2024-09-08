import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutterapp/src/providers/locale_provider.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatefulWidget {
  static const routeName = '/settings';

  final SettingsController? controller;

  const SettingsView({Key? key, this.controller});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  Color? baseColor = const Color(0xFFF2F2F2);

  List<String?>? localeNamesList = [
    'Country',
    'English',
    /* 'français',
    'Español',*/
    'ألعربيه',
/*    'اردو',*/
  ];
  String? localeCode;
  String? localeCountry;

  LocaleFlags? selectedFlag;

  List<LocaleFlags>? flags = [
    LocaleFlags(localeCode: 'en', localeCountry: 'US'),
/*    LocaleFlags(localeCode: 'fr', localeCountry: 'FR'),
    LocaleFlags(localeCode: 'es', localeCountry: 'ES'),*/
    LocaleFlags(localeCode: 'ar', localeCountry: 'AE'),
/*    LocaleFlags(localeCode: 'hi', localeCountry: 'IN'),*/
  ];
  List<String?>? localeNamesListing = [
    "English",
    /* 'français',
    'Español',*/
    'ألعربيه',
    /*   'اردو',*/
  ];

  String? defaultDropdownValue = "Language";

  /* List<String?>? languageCode = ['en', 'fr', 'es', 'ar', 'hi'];
  List<String?>? countryCode = ['US', 'FR', 'ES', 'AE', 'IN'];*/

  List<String?>? languageCode = ['en', 'ar'];
  List<String?>? countryCode = ['US', 'AE'];

  //Here we pass the user selected locale to the products page view to show the
  //alignment of the locale accordingly
  LocaleProvider? localeProvider;
  String? selectedLocaleCode;
  String? selectedLocaleCountry;

  @override
  Widget build(BuildContext context) {
    localeProvider = Provider.of<LocaleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'generalUse-settings'.tr().toString(),
          style: const TextStyle(
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF3D82AE),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 100.0, top: 100.0),
        child: Column(
          children: [
            /*Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Card(
                color: Colors.white,
                elevation: 10.0,
                shape: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                borderOnForeground: true,
                margin: const EdgeInsets.all(3.0),
                clipBehavior: Clip.hardEdge,
                child: DropdownButton<ThemeMode>(
                  // Read the selected themeMode from the controller
                  value: widget.controller!.themeMode,
                  // Call the updateThemeMode method any time the user selects a theme.
                  onChanged: widget.controller!.updateThemeMode,
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(
                        'System Theme',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(
                        'Light Theme',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(
                        'Dark Theme',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),*/
            const SizedBox(
              height: 60.0,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Color(0xFF3D82AE).withOpacity(0.4)),
                  elevation: WidgetStateProperty.all(15.0),
                ),
                onPressed: () {},
                child: DropDown<LocaleFlags>(
                  dropDownType: DropDownType.Button,
                  showUnderline: false,
                  /*icon: Icon(
                            Icons.language,
                            size: 25.0,
                            color: Colors.black,
                        ),*/
                  items: flags!,
                  hint: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.language_outlined,
                        size: 40.0,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        'generalUse-selectLang'.tr().toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  customWidgets: LocaleFlags().flagsWidget(),
                  initialValue: flags!.first,
                  onChanged: (lo) => applySelectedLocale(lo),
                  isCleared: selectedFlag == null,
                  isExpanded: false,
                ),
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            //Share App
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 80.0,
                  maxWidth: 80.0,
                  minHeight: 60.0,
                  maxHeight: 60.0,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith(
                        (states) => Color(0xFF3D82AE).withOpacity(0.4)),
                    elevation: WidgetStateProperty.all(20.0),
                  ),
                  child: Icon(
                    Icons.share,
                    size: 25.0,
                    color: Colors.white,
                  ),
                  onPressed: () => context.go('/e/shareappRoute'),
                ),
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      //bottomNavigationBar: NavigationBarSection(),
    );
  }

  applySelectedLocale(lo) {
    setState(() {
      /// Here We change the Locale
      selectedFlag = lo;
      EasyLocalization.of(context)!.setLocale(
        Locale(selectedFlag!.localeCode!, selectedFlag!.localeCountry),
      );
      selectedLocaleCode = selectedFlag!.localeCode;
      selectedLocaleCountry = selectedFlag!.localeCountry;
      //We save the selected locale in provider to apply in
      // all pages
      localeProvider!.setLocaleCode('');
      localeProvider!.setLocaleCode(selectedLocaleCode);
      //
      context.go('/');
      //var locale = Locale(selectedFlag.localeCode, selectedFlag.localeCountry);
      //locale = EasyLocalization.of(context).locale ;
      //Navigator.pushNamed(context, '/homeRoute');
    });
  }

  changeLocaleValue(String? lo) {
    setState(() {
      defaultDropdownValue = lo;
    });

    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, "/searchMainPage");
    });
  }
}

class LocaleFlags {
  final String? localeCode;
  final String? localeCountry;

  LocaleFlags({this.localeCode, this.localeCountry});

  List<Widget>? flagsWidget() {
    return [
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5.0),
        constraints: BoxConstraints(
          minWidth: 150.0,
          maxWidth: 150.0,
          minHeight: 30.0,
          maxHeight: 30.0,
        ),
        color: null,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.blue,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Text(
                'English',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Image(
                image: AssetImage('assets/images/usaFlag.webp'),
              ),
            ),
          ],
        ),
      ),
      /*  Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5.0),
        constraints: BoxConstraints(
          minWidth: 150.0,
          maxWidth: 150.0,
          minHeight: 30.0,
          maxHeight: 30.0,
        ),
        color: null,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.blue,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Text(
                "français",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Image(
                image: AssetImage('assets/images/frenchFlag.png'),
              ),
            ),
          ],
        ),
      ),*/
      /* Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5.0),
        constraints: BoxConstraints(
          minWidth: 150.0,
          maxWidth: 150.0,
          minHeight: 30.0,
          maxHeight: 30.0,
        ),
        color: null,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.blue,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Text(
                "Español",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Image(
                image: AssetImage('assets/images/spainFlag.png'),
              ),
            ),
          ],
        ),
      ),*/
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5.0),
        constraints: BoxConstraints(
          minWidth: 150.0,
          maxWidth: 150.0,
          minHeight: 30.0,
          maxHeight: 30.0,
        ),
        color: null,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.blue,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Text(
                "ألعربيه",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Image(
                image: AssetImage('assets/images/UAEFlag.webp'),
              ),
            ),
          ],
        ),
      ),
      /*Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5.0),
        constraints: BoxConstraints(
          minWidth: 150.0,
          maxWidth: 150.0,
          minHeight: 30.0,
          maxHeight: 30.0,
        ),
        color: null,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.blue,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Text(
                "اردو",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Image(
                image: AssetImage('assets/images/indiaFlag.png'),
              ),
            ),
          ],
        ),
      ),*/
    ];
  }
}
