import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutterapp/src/providers/locale_provider.dart';

import 'package:flutterapp/src/settings/settings_controller.dart';

class ShareApp extends StatelessWidget {
  static const routeName = "/shareappRoute";
  final SettingsController? controller;

  LocaleProvider? localeProvider;
  String? selectedLocaleCode;

  ShareApp({Key? key, this.controller,this.selectedLocaleCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Applying new selected locale on this page
    var localeProvider = Provider.of<LocaleProvider>(context);
    selectedLocaleCode = localeProvider.selectedLocaleCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'generalUse-shareapp'.tr().toString(),
          style: const TextStyle(
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        backgroundColor:Color(0xFF3D82AE),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) => Color(0xFF3D82AE)),
                elevation: WidgetStateProperty.all(20.0),
              ),
              child:Text(
                'generalUse-shareLink'.tr().toString(),
                style: const TextStyle(
                  fontSize: 22.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2.0,
                  color: Colors.white,
                  backgroundColor: Color(0xFF3D82AE),
                ),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              onPressed: () => Share.share(
                'https://play.google.com/store/apps/details?id=net.deziretechcom.tabarak&pli=1',
                subject: 'generalUse-subject'.tr().toString(),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
