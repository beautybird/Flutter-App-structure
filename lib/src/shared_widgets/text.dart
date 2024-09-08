import 'package:flutter/material.dart';

import 'mix_properties.dart';

class TextStandard extends StatelessWidget {
  String? textDetails;
  double? fontSize;
  Color? fontColor;
  Locale? selectLocale;
  Languages_Codes? languagesCodes;


  TextStandard({this.textDetails, this.fontSize, this.fontColor,
      this.selectLocale, this.languagesCodes});

  @override
  Widget build(BuildContext context) {
    return Text(
      textDetails!,
      textAlign: TextAlign.start,
      softWrap: true,
      //overflow: TextOverflow.visible,
      textDirection: Text_Direction.text_direction[0],
      locale: selectLocale,
      textScaleFactor: 1.0,
      maxLines: 8,
      textWidthBasis: TextWidthBasis.longestLine,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        letterSpacing: 0.0,
        wordSpacing: 0.0,
        textBaseline: TextBaseline.alphabetic,
        /*foreground: Paint()
              ..shader = ui.Gradient.linear(
                const Offset(0, 20),
                const Offset(150, 20),
                <Color>[
                  Colors.red,
                  Colors.yellow,
                ],
              ),*/
        foreground: Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = 2
          ..color = Colors.black,
        //decoration: TextDecoration.underline,
        decorationColor: Colors.red,
        decorationStyle: TextDecorationStyle.wavy,
        shadows: Text_Shadow.text_shadow_list,
      ),
    );
  }
}
/*

class Text_Item extends StatelessWidget {

  String text_details;
  double font_size;
  Color font_color;
  Locale select_locale;
  Languages_Codes languages_codes;

  Text_Item(
      {this.text_details, this.font_size, this.font_color, this.select_locale, this.languages_codes});


  @override
  Widget build(BuildContext context) {
    return Text(
      text_details,
      textAlign: TextAlign.start,
      softWrap: true,
      //overflow: TextOverflow.visible,
      textDirection: Text_Direction.text_direction[0],
      locale: select_locale,
      textScaleFactor: 1.0,
      maxLines: 8,
      textWidthBasis: TextWidthBasis.longestLine,
      style: TextStyle(
        color: font_color,
        fontSize: font_size,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        letterSpacing: 0.0,
        wordSpacing: 0.0,
        textBaseline: TextBaseline.alphabetic,
        */
/*foreground: Paint()
              ..shader = ui.Gradient.linear(
                const Offset(0, 20),
                const Offset(150, 20),
                <Color>[
                  Colors.red,
                  Colors.yellow,
                ],
              ),*//*

        foreground: Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = 2
          ..color = Colors.black,
        //decoration: TextDecoration.underline,
        decorationColor: Colors.red,
        decorationStyle: TextDecorationStyle.wavy,
        shadows: Text_Shadow.text_shadow_list,
      ),
    );
  }
}*/
