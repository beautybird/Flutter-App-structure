import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class ClayContainerStandard extends StatelessWidget {
  Color? baseColor = Color(0xFFF2F2F2);
  double? cCHeight;
  Color? cCColor;
  Color? cCParentColor;
  Color? cCSurfaceColor;
  double? cCSpread;
  double? cCBorderRadius;
  BorderRadius? cCCustomBorderRadius;
  CurveType? cCCurveType;
  int? cCDepth;
  Widget? child;

  ClayContainerStandard(
      {this.baseColor,
      this.cCHeight,
      this.cCColor,
      this.cCParentColor,
      this.cCSurfaceColor,
      this.cCSpread,
      this.cCBorderRadius,
      this.cCCustomBorderRadius,
      this.cCCurveType,
      this.cCDepth,
      this.child});

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      height: cCHeight,
      color: cCColor,
      parentColor: cCParentColor,
      surfaceColor: cCSurfaceColor,
      spread: cCSpread,
      borderRadius: cCBorderRadius,
      customBorderRadius: cCCustomBorderRadius,
      curveType: cCCurveType,
      depth: cCDepth,
      emboss: true,
      child: child,
    );
  }
}

class ClayTextStandard extends StatelessWidget {
  String? clayText;
  Color? cTParentColor;
  Color? cTTextColor;
  Color? cTColor;
  double? cTSpread;
  int? cTDepth;
  TextStyle? cTStyle;
  double? cTSize;

  ClayTextStandard({this.clayText, this.cTParentColor, this.cTTextColor,
      this.cTColor, this.cTSpread, this.cTDepth, this.cTStyle, this.cTSize});

  @override
  Widget build(BuildContext context) {
    return ClayText(
      clayText!,
      parentColor: cTParentColor,
      textColor: cTTextColor,
      color: cTColor,
      spread: cTSpread,
      depth: cTDepth,
      style: cTStyle,
      size: cTSize,
      emboss: true,
    );
  }
}

class ClayContainerDesign extends StatelessWidget {
  Color? containerColor;
  double? borderRadius;
  BorderRadius? customBorderRadius;
  CurveType? curveType;
  double? height;
  String? textDetails;
  double? clayTextSize;
  Color? clayTextColor;
  Color? clayTextColorText;

  ClayContainerDesign(
      {this.containerColor,
        this.borderRadius,
        this.customBorderRadius,
        this.curveType,
        this.height,
        this.textDetails,
        this.clayTextSize,
        this.clayTextColor,
        this.clayTextColorText});

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      color: containerColor,
      borderRadius: borderRadius,
      customBorderRadius: customBorderRadius,
      curveType: curveType,
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        child: ClayText(
          textDetails!,
          emboss: true,
          size: clayTextSize,
          depth: 60,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            letterSpacing: 1.0,
          ),
          color: clayTextColor,
          textColor: clayTextColorText,
        ),
      ),
    );
  }
}

class ClayContainerCompanyName extends StatelessWidget {

  Color baseColor = Color(0xFFF2F2F2);

  Color? containerColor;
  double? borderRadius;
  BorderRadius? customBorderRadius;
  CurveType? curveType;
  double? height;
  String? textDetails;
  double? clayTextSize;
  Color? clayTextColor;
  Color? clayTextColorText;

  ClayContainerCompanyName(
      {this.containerColor,
        this.borderRadius,
        this.customBorderRadius,
        this.curveType,
        this.height,
        this.textDetails,
        this.clayTextSize,
        this.clayTextColor,
        this.clayTextColorText});
  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      color: containerColor,
      borderRadius: borderRadius,
      customBorderRadius: customBorderRadius,
      curveType: curveType,
      height: height,
      width: 450.0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: TextLiquidFill(
          text: textDetails!,
          waveColor: Colors.lightBlueAccent,
          boxBackgroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
          boxHeight: 55.0,
          boxWidth: 450.0,
        ),
      ),
    );
  }
}


