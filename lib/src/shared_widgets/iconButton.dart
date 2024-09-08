import 'package:flutter/material.dart';

class IconButtonDesign extends StatelessWidget {
  final double? iconSize;
  final Color? iconColor;
  final Color? iconHoverColor;
  final Color? iconHighlightColor;
  final Color? iconSplashColor;
  final Color? disabledColor;
  final String? iconTooltip;
  final bool? autofocus;
  final BoxConstraints? iconConstraints;
  final Widget? icon;
  final Function()? onPressed;

  IconButtonDesign(
      {this.iconSize,
      this.iconColor,
      this.iconHoverColor,
      this.iconHighlightColor,
      this.iconSplashColor,
      this.disabledColor,
      this.iconTooltip,
      this.autofocus,
      this.iconConstraints,
      this.icon,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize!,
      splashRadius: 15.0,
      color: iconColor,
      hoverColor: iconHoverColor,
      highlightColor: iconHighlightColor,
      splashColor: iconSplashColor,
      disabledColor: disabledColor,
      tooltip: iconTooltip,
      autofocus: autofocus!,
      constraints: iconConstraints,
      icon: icon!,
      onPressed: onPressed!,
    );
  }
}
