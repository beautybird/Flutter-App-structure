import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'buttons.dart';
import 'mix_properties.dart';

class ContainerStandard extends StatelessWidget {
  final Alignment? alignment;
  final EdgeInsets? padding;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final Color? color;
  final Color? boxDecorationColor;
  final Color? boxBorderColor;
  final BorderRadius? boxBorderRadius;
  final Color? gradientColorOne;
  final Color? gradientColorTwo;
  final Border? boxBorder;
  final DecorationImage? boxImage;
  final Widget? child;
  final int? containerID;

  const ContainerStandard(
      {Key? key,
      this.alignment,
      this.padding,
      this.minWidth,
      this.maxWidth,
      this.minHeight,
      this.maxHeight,
      this.color,
      this.boxDecorationColor,
      this.boxBorderColor,
      this.boxBorder,
      this.gradientColorOne,
      this.gradientColorTwo,
      this.boxBorderRadius,
      this.boxImage,
      this.child,
      this.containerID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      color: color,
      constraints: BoxConstraints(
        minWidth: minWidth!,
        maxWidth: maxWidth!,
        minHeight: minHeight!,
        maxHeight: maxHeight!,
      ),
      decoration: BoxDecoration(
        color: boxDecorationColor,
        image: boxImage,
        border: boxBorder,
        borderRadius: boxBorderRadius,
        boxShadow: Box_Shadow().boxShadows(),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [gradientColorOne!,gradientColorTwo!],
          stops: const [0.1, 0.8],
          tileMode: TileMode.clamp,
          transform: const GradientRotation(0.45),
        ),
        backgroundBlendMode: BlendMode.color,
        shape: BoxShape.rectangle,
      ),
      child: child,
    );
  }
}
/*

class ContainerRegisterBuyerTextChild extends StatelessWidget {
  final double containerHeight;

  ContainerRegisterBuyerTextChild({this.containerHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      // color: Colors.blue[100],
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        */
/*image:DecorationImage(
                      image:AssetImage('res/'),
                      colorFilter:ColorFilter.linearToSrgbGamma() ,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                      centerSlice: Rect.fromLTRB(1.0, 1.0, 1.0, 1.0),
                      repeat: ImageRepeat.noRepeat,
                      matchTextDirection: false
                ),*/ /*

        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border:
            Border.all(color: Colors.red, width: 0.8, style: BorderStyle.solid),
        boxShadow: Box_Shadow().boxShadows(),
        */
/*gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.teal[200], Colors.green[100]],
            stops: [0.1, 0.8],
            tileMode: TileMode.clamp,
            transform: GradientRotation(0.45)),*/ /*

        shape: BoxShape.rectangle,
      ),
      child: Text_Item(
        text_details:
            "Buyer Register Account here , selected country will be your default search , you may change the country in your account page later",
        font_size: 17,
      ),
    );
  }
}

class ContainerRegisterSellerTextChild extends StatelessWidget {
  final double containerHeight;

  ContainerRegisterSellerTextChild({this.containerHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      // color: Colors.blue[100],
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        */
/*image:DecorationImage(
                      image:AssetImage('res/'),
                      colorFilter:ColorFilter.linearToSrgbGamma() ,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                      centerSlice: Rect.fromLTRB(1.0, 1.0, 1.0, 1.0),
                      repeat: ImageRepeat.noRepeat,
                      matchTextDirection: false
                ),*/ /*

        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border:
            Border.all(color: Colors.red, width: 0.8, style: BorderStyle.solid),
        boxShadow: Box_Shadow().boxShadows(),
        */
/*gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.teal[200], Colors.green[100]],
            stops: [0.1, 0.8],
            tileMode: TileMode.clamp,
            transform: GradientRotation(0.45)),*/ /*

        shape: BoxShape.rectangle,
      ),
      child: Text_Item(
        text_details:
            "Seller Register Account here , selected country will be your default country , you may change the country in your account page later",
        font_size: 15,
      ),
    );
  }
}

class Container_TextChild extends StatelessWidget {
  final double container_height;

  Container_TextChild({this.container_height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: container_height,
      // color: Colors.blue[100],
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        */
/*image:DecorationImage(
                      image:AssetImage('res/'),
                      colorFilter:ColorFilter.linearToSrgbGamma() ,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                      centerSlice: Rect.fromLTRB(1.0, 1.0, 1.0, 1.0),
                      repeat: ImageRepeat.noRepeat,
                      matchTextDirection: false
                ),*/ /*

        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border:
            Border.all(color: Colors.red, width: 0.8, style: BorderStyle.solid),
        boxShadow: Box_Shadow().boxShadows(),
        */
/*gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.teal[200], Colors.green[100]],
            stops: [0.1, 0.8],
            tileMode: TileMode.clamp,
            transform: GradientRotation(0.45)),*/ /*

        shape: BoxShape.rectangle,
      ),
      child: Text_Item(
        text_details:
            'Sellers :- If you wish to create a shop area ,login to your account,complete all fields about your shop .The shop will be online '
            'for 30 days free trial & 1 category to advertise in the free trial and 3 categories with the paid annual subscription.',
        font_size: 19.0,
        //font_color: Colors.black,
      ),
    );
  }
}
*/

class Container_Advertisment extends StatelessWidget {
  final double? container_height;
  final Uint8List? imageSource;

  Container_Advertisment({this.container_height, this.imageSource});

  List<dynamic>? linearList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: container_height,
      //color: Colors.blue[100],
      alignment: Alignment.center,
      padding: EdgeInsets.all(2.0),
      margin: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        //color: Colors.blue[100],
        /*image: DecorationImage(
            image: AssetImage(adver_image),
            colorFilter: ColorFilter.linearToSrgbGamma(),
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            centerSlice: Rect.fromLTRB(1.0, 1.0, 1.0, 1.0),
            repeat: ImageRepeat.noRepeat,
            matchTextDirection: false),*/
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
            color: Colors.white, width: 0.8, style: BorderStyle.solid),
        boxShadow: Box_Shadow().boxShadows(),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.white, Colors.white],
            stops: [0.1, 0.8],
            tileMode: TileMode.clamp,
            transform: GradientRotation(0.45)),
        shape: BoxShape.rectangle,
      ),
      child: Image.memory(
        imageSource!,
        width: 400.0,
        height: 100.0,
        fit: BoxFit.fill,
        alignment: Alignment.center,
        errorBuilder: (ctx, o, n) {
          print(o);
          print(n);
          return Image.asset('res/noproduct.png', fit: BoxFit.contain);
        },
      ),
    );
  }
}
/*

class ContainerShopMapArea extends StatelessWidget {
  final double? containerHeight;
  final double? containerWidth;
  final BoxConstraints? containerConstraints;
  final Widget? child;

  ContainerShopMapArea({
    this.containerHeight,
    this.containerWidth,
    this.containerConstraints,
    this.child,
  });

  final List<BoxShadow> boxShadowList = [boxshadow, boxShadow1];
  static final BoxShadow boxshadow = BoxShadow(
      color: Colors.red,
      offset: Offset.infinite,
      blurRadius: 0.1,
      spreadRadius: 0.8);
  static final BoxShadow boxShadow1 = BoxShadow(
      color: Colors.orangeAccent,
      offset: Offset.infinite,
      blurRadius: 0.2,
      spreadRadius: 0.9);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(2.0),
      width: containerWidth,
      height: containerHeight,
      constraints: containerConstraints,
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        //color: Colors.blue[100],
        */
/*image: DecorationImage(
            image: AssetImage(adver_image),
            colorFilter: ColorFilter.linearToSrgbGamma(),
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            centerSlice: Rect.fromLTRB(1.0, 1.0, 1.0, 1.0),
            repeat: ImageRepeat.noRepeat,
            matchTextDirection: false),*/ /*

        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
          color: Colors.blue,
          width: 0.8,
          style: BorderStyle.solid,
        ),
        boxShadow: boxShadowList,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.yellow,
            Colors.yellow,
          ],
          //stops: [0.1, 0.8],
          //tileMode: TileMode.clamp,
          //transform: GradientRotation(0.45)
        ),
        shape: BoxShape.rectangle,
      ),
      child: child,
    );
  }
}
*/

class ContainerElevatedButton extends StatelessWidget {
  final double? containerHeight;
  final StandardElevatedButton? elevatedButton;
  final String? adverImage;
  final List<BoxShadow>? boxShadowList;
  ContainerElevatedButton(
      {this.containerHeight,
      this.elevatedButton,
      this.adverImage,
      this.boxShadowList});

  static final BoxShadow boxShadow = BoxShadow(
      color: Colors.red,
      offset: Offset.infinite,
      blurRadius: 0.1,
      spreadRadius: 0.8);
  static final BoxShadow boxShadow1 = BoxShadow(
      color: Colors.orangeAccent,
      offset: Offset.infinite,
      blurRadius: 0.2,
      spreadRadius: 0.9);
  List<BoxShadow> boxShadowListValues() {
    boxShadowList!.add(boxShadow);
    boxShadowList!.add(boxShadow1);
    return boxShadowList!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      //color: Colors.blue[100],
      alignment: Alignment.center,
      padding: EdgeInsets.all(2.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        //color: Colors.blue[100],
        image: DecorationImage(
            image: AssetImage(adverImage!),
            colorFilter: ColorFilter.linearToSrgbGamma(),
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            centerSlice: Rect.fromLTRB(1.0, 1.0, 1.0, 1.0),
            repeat: ImageRepeat.noRepeat,
            matchTextDirection: false),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
            color: Colors.blue, width: 0.8, style: BorderStyle.solid),
        boxShadow: boxShadowListValues(),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.green, Colors.green,
              //stops: [0.1, 0.8],
              //tileMode: TileMode.clamp,
              //transform: GradientRotation(0.45),
            ]),
        shape: BoxShape.rectangle,
      ),
      child: elevatedButton,
    );
  }
}

/*
class ContainerHomePageNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        //color: Colors.blue[100],
        */
/*image: DecorationImage(
            image: AssetImage(adver_image),
            colorFilter: ColorFilter.linearToSrgbGamma(),
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            centerSlice: Rect.fromLTRB(1.0, 1.0, 1.0, 1.0),
            repeat: ImageRepeat.noRepeat,
            matchTextDirection: false),*/ /*

        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
            color: Colors.white, width: 0.8, style: BorderStyle.solid),
        boxShadow: Box_Shadow().boxShadows(),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.white, Colors.white],
            stops: [0.1, 0.8],
            tileMode: TileMode.clamp,
            transform: GradientRotation(0.45)),
        shape: BoxShape.rectangle,
      ),
      foregroundDecoration: null,
      width: 200.0,
      height: 100.0,
      constraints: BoxConstraints(
          minWidth: 200.0, maxWidth: 300.0, minHeight: 100.0, maxHeight: 150.0),
      margin: EdgeInsets.all(5.0),
      child: Text(
        'Select Country & Category and you search will start',
        style: TextStyle(
            color: Colors.blue,
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
*/
