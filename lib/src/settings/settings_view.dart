import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatefulWidget {

  static const routeName = '/settings';

  final SettingsController? controller;
  final String? lable;

  SettingsView({Key? key,  this.controller,this.lable}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  Color baseColor = const Color(0xFFF2F2F2);

  List<String> localeNamesList = [
    'Country',
    'English',
    /*'français',
    'Español',*/
    'عربي',
    /*'اردو',*/
  ];
  String? localeCode;
  String? localeCountry;

  LocaleFlags? selectedFlag;

  List<LocaleFlags> flags = [
    LocaleFlags(localeCode: 'en', localeCountry: 'US'),
    /*LocaleFlags(localeCode: 'fr', localeCountry: 'FR'),
    LocaleFlags(localeCode: 'es', localeCountry: 'ES'),*/
    LocaleFlags(localeCode: 'ar', localeCountry: 'AE'),
    /* LocaleFlags(localeCode: 'hi', localeCountry: 'IN'),*/
  ];

  List<String> languageCode = ['en', 'ar'];
  List<String> countryCode = ['US', 'AE'];

  /*List<String> languageCode = ['en','fr','es','ar','hi'];
  List<String> countryCode = ['US','FR','ES','AE','IN'];*/

  //Here we pass the user selected locale to the products page view to show the
  //alignment of the locale accordingly
  String? selectedLocaleCode;
  _SettingsViewState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings_settings'.tr().toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: DropdownButton<ThemeMode>(
                // Read the selected themeMode from the controller
                value: widget.controller!.themeMode,
                // Call the updateThemeMode method any time the user selects a theme.
                onChanged: widget.controller!.updateThemeMode,
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('System Theme'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light Theme'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Dark Theme'),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: DropDown<LocaleFlags>(
                items: flags,
                customWidgets: LocaleFlags().flagsWidget(),
                initialValue: flags.first,
                onChanged: (lo) {
                  /// Here We change the Locale
                  setState(() {
                    selectedFlag = lo;
                    EasyLocalization.of(context)!.setLocale(
                      Locale(selectedFlag!.localeCode!,
                          selectedFlag!.localeCountry),
                    );
                    selectedLocaleCode = selectedFlag!.localeCode;

                    //var locale = Locale(selectedFlag.localeCode, selectedFlag.localeCountry);
                    //locale = EasyLocalization.of(context).locale ;
                  });
                },
                isCleared: selectedFlag == null,
                isExpanded: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocaleFlags {
  final String? localeCode;
  final String? localeCountry;

  LocaleFlags({this.localeCode, this.localeCountry});

  List<Widget> flagsWidget() {
    return [
      Container(
        constraints: const BoxConstraints(
            minWidth: 70.0, maxWidth: 80.0, minHeight: 30.0, maxHeight: 40.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Expanded(
              flex: 1,
              child: Text(
                'En',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 1,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30.0,
                backgroundImage: AssetImage('assets/images/usaFlag.webp'),
                onBackgroundImageError: (obj, stackTrace) {},
              ),
            ),
          ],
        ),
      ),
      Container(
        constraints: const BoxConstraints(
            minWidth: 70.0, maxWidth: 80.0, minHeight: 30.0, maxHeight: 40.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                'عربي',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 1,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/UAEFlag.webp'),
                radius: 30.0,
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
