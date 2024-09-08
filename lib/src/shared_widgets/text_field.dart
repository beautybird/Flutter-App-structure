import 'package:flutter/material.dart';

class TextFieldStandard extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? prefixWidget;
  final Color? prefixWidgetColor;
  final Widget? labelWidget;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? errorText;
  final TextStyle? errorTextStyle;
  final int? errorMaxLines;
  final InputBorder? errorInputBorder;
  final Color? fieldBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final Widget? suffixWidget;
  final Widget? suffixIconWidget;
  final Color? suffixIconColor;
  final BoxConstraints? suffixIconConstraint;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final Widget? counter;
  final String? counterText;
  final TextStyle? counterTextStyle;

  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final String? obscuringCharacter;
  final bool obscureText = false;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;

  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final String? suffixTooltip;
  final Function()? suffixOnPressed;
  final RegExp? regExp /*= new RegExp(r'^[a-zA-Z0-9_]+( [a-zA-Z0-9_]+)*$')*/;
  final Iterable<RegExpMatch>? matches;
  final String? Function(String?)? validate;
  final bool? obsecureText;
  final Locale? locale;
  final InputBorder? outlineInputBorder;

  const TextFieldStandard({
    Key? key,
    this.controller,
    this.focusNode,
    this.prefixWidget,
    this.prefixWidgetColor,
    this.labelWidget,
    this.labelText,
    this.labelStyle,
    this.floatingLabelStyle,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.errorText,
    this.errorTextStyle,
    this.errorMaxLines,
    this.errorInputBorder,
    this.contentPadding,
    this.fieldBorderColor,
    this.textInputType,
    this.textInputAction,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixIconSize,
    this.suffixWidget,
    this.suffixIconWidget,
    this.suffixIconColor,
    this.suffixIconConstraint,
    this.suffixText,
    this.suffixTextStyle,
    this.counter,
    this.counterText,
    this.counterTextStyle,
    this.textStyle,
    this.textAlign,
    this.textAlignVertical,
    this.textCapitalization,
    this.autofocus,
    this.obscuringCharacter,
    this.obsecureText,
    this.smartDashesType,
    this.smartQuotesType,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.suffixTooltip,
    this.suffixOnPressed,
    this.regExp,
    this.matches,
    this.validate,
    this.locale,
    this.outlineInputBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        icon: prefixWidget,
        iconColor: prefixWidgetColor,
        label: labelWidget,
        labelText: labelText,
        labelStyle: labelStyle,
        floatingLabelStyle: floatingLabelStyle,
        floatingLabelAlignment: floatingLabelAlignment,
        floatingLabelBehavior: floatingLabelBehavior,
        //hintText: 'Type Your Password',
        //hintStyle: TextStyle(color: Colors.black87,fontSize: 16.0),
        errorText: errorText,
        errorStyle: errorTextStyle,
        errorMaxLines: errorMaxLines,
        errorBorder: errorInputBorder,
        isDense: false,
        contentPadding: contentPadding,
        prefixIcon: Icon(
          prefixIcon,
          color: prefixIconColor,
          size: prefixIconSize,
        ),
        suffix: suffixWidget,
        suffixIcon: suffixIconWidget,
        suffixIconColor: suffixIconColor,
        suffixIconConstraints: suffixIconConstraint,
        suffixText: suffixText,
        suffixStyle: suffixTextStyle,
        counter: counter,
        counterText: counterText,
        counterStyle: counterTextStyle,
        border: outlineInputBorder,
      ),
      keyboardType: textInputType,
      textInputAction: textInputAction,
      style: textStyle,
      textAlign: textAlign!,
      textAlignVertical: textAlignVertical,
      textCapitalization: textCapitalization!,
      readOnly: false,
      contextMenuBuilder: (BuildContext context,EditableTextState ETS){
        return Text('');
      },
      showCursor: true,
      autofocus: autofocus!,
      obscuringCharacter: obscuringCharacter!,
      obscureText:obscureText,
      autocorrect: true,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: true,
      maxLines: maxLines,
      minLines: minLines,
      expands: false,
      maxLength: maxLength,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onFieldSubmitted,
      onTap: onTap,
    );
  }
}
