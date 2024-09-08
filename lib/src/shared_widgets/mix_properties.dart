import 'package:flutter/material.dart';


class Box_Shadow {
  Box_Shadow() {
    boxShadows();
  }
  List<BoxShadow> boxShadows() {
    List<BoxShadow> box_shadow_list = [];

    final BoxShadow boxShadow = BoxShadow(
      color: Colors.grey,
      offset: Offset.infinite,
      blurRadius: 0.1,
      spreadRadius: 0.7,
    );
    final BoxShadow boxShadow1 = BoxShadow(
      color: Colors.grey,
      offset: Offset.infinite,
      blurRadius: 0.3,
      spreadRadius: 0.8,
    );
    box_shadow_list.add(boxShadow);
    box_shadow_list.add(boxShadow1);

    return box_shadow_list;
  }
}

class Text_Direction {
  static List<TextDirection> text_direction = [
    TextDirection.ltr,
    TextDirection.rtl
  ];
}

class Text_Shadow {
  /*.... Text Shadows ...*/
  static final Shadow shadowOne = Shadow(
    color: Colors.red,
    offset: Offset.infinite,
    blurRadius: 0.1,
  );
  static final Shadow shadowTwo = Shadow(
    color: Colors.orangeAccent,
    offset: Offset.infinite,
    blurRadius: 0.2,
  );

  static List<Shadow> text_shadow_list = [shadowOne, shadowTwo];
}

class Languages_Codes {
  /*languages codes here : https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry*/

  List<String> languages_codes = [Arabic, English];
  static String Arabic = 'ar';
  static String English = 'en';

  //Languages_Codes(this.English,this.Arabic);

  List<String> languages() {
    languages_codes.add(Arabic);
    languages_codes.add(English);

    return languages_codes;
  }
}
