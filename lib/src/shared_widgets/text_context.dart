import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/src/providers/locale_provider.dart';
import 'package:flutterapp/src/shared_widgets/form_text_field.dart';
import 'package:flutterapp/src/shared_widgets/if_url_valid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'platform_selector.dart';

import 'is_valid_email.dart';

class TextFieldContextMenu extends StatefulWidget {
  const TextFieldContextMenu({super.key});

  @override
  State<TextFieldContextMenu> createState() => _TextFieldContextMenuState();
}

class _TextFieldContextMenuState extends State<TextFieldContextMenu> {
  //Locale
  LocaleProvider? localeProvider;
  String? selectedLocaleCode;

  ///Text Field Controller
  final _controller = TextEditingController();
  //
  String? textFieldValue;
  String? getTextFieldCurrentValue() {
    return textFieldValue =
        ((_controller.text).isNotEmpty ? _controller.text : '');
  }

  ///
  String? kCodeUrl =
      'https://github.com/flutter/samples/blob/experimental/context_menus/lib';

  ///
  DialogRoute _showDialog(BuildContext context) {
    return DialogRoute<void>(
      context: context,
      builder: (context) =>
          const AlertDialog(title: Text('You clicked ')),
    );
  }

  ///
  @override
  void initState() {
    ///Add Listener the controller
    _controller.addListener(() {
      getTextFieldCurrentValue();
    });
    super.initState();
  }

  @override
  void dispose() {
    ///Dispose the text field controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Applying new selected locale on this page
    localeProvider = Provider.of<LocaleProvider>(context);
    selectedLocaleCode = localeProvider!.selectedLocaleCode;
    //
    return StandardFormTextField(
      controller: _controller,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      fieldBorderColor: Colors.blue,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontColor: Colors.black,
      prefixIcon: Icons.type_specimen,
      prefixIconColor: Colors.black,
      suffixTooltip: 'generalUse-video'.tr().toString(),
      obsecureText: false,
      maxLines: 1,
      formTextFieldLabel: 'generalUse-video'.tr().toString(),
      validate: (stringFieldValue) => stringFieldValue!.isEmpty == true
          ? 'generalUse-fillAllDetails'.tr().toString()
          : null,
      suffixOnPressed: () => _controller.clear(),
      locale: Locale(localeProvider!.selectedLocaleCode!,
          localeProvider!.selectedLocaleCountry),
      contextMenuBuilder: (context, editableTextState) {
        final TextEditingValue value = editableTextState.textEditingValue;
        final List<ContextMenuButtonItem> buttonItems =
            editableTextState.contextMenuButtonItems;
        if (isValidEmail(value.selection.textInside(value.text))) {
          buttonItems.insert(
              0,
              ContextMenuButtonItem(
                label: 'Send email',
                onPressed: () {
                  ContextMenuController.removeAny();
                  Navigator.of(context).push(_showDialog(context));
                },
              ));
        }else if(isValidUrl(value.selection.textInside(value.text))){
          buttonItems.insert(
            1,
            ContextMenuButtonItem(
              label: 'Paste',
              onPressed:(){
                ContextMenuController.removeAny();
                Navigator.of(context).push(_showDialog(context));
              }),
          );
        }
        return AdaptiveTextSelectionToolbar.buttonItems(
          /*editableTextState: editableTextState,*/
          anchors: editableTextState.contextMenuAnchors,
          buttonItems: buttonItems,
        );
      },
    );
  }
}
class TextFieldContext extends StatelessWidget {
  TextFieldContext({
    super.key,
    required this.onChangedPlatform,
  });
  static const String kCodeUrl =
      'https://github.com/flutter/samples/blob/experimental/context_menus/lib';

  static const String route = 'field-types';
  static const String title = 'The Context Menu in Different Field Types';
  static const String subtitle =
      'How contextual menus work in TextField, CupertinoTextField, and EditableText';
  static const String url = '$kCodeUrl/field_types_page.dart';

  final PlatformCallback onChangedPlatform;

  final TextEditingController _controller = TextEditingController(
    text:
        "Material text field shows the menu for any platform by default. You'll see the correct menu for your platform here.",
  );

  final TextEditingController _cupertinoController = TextEditingController(
    text:
        "CupertinoTextField can't show Material menus by default. On non-Apple platforms, you'll still see a Cupertino menu here.",
  );

  final TextEditingController _cupertinoControllerFixed = TextEditingController(
    text:
        "But CupertinoTextField can be made to adaptively show any menu. You'll see the correct menu for your platform here.",
  );

  final TextEditingController _cupertinoControllerForced =
      TextEditingController(
    text: 'Or forced to always show a specific menu (Material desktop menu).',
  );

  final TextEditingController _editableController = TextEditingController(
    text:
        "EditableText doesn't show any selection menu by itself, even when contextMenuBuilder is passed.",
  );

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(TextFieldContext.title),
          actions: <Widget>[
            PlatformSelector(
              onChangedPlatform: onChangedPlatform,
            ),
            IconButton(
              icon: const Icon(Icons.code),
              onPressed: () async {
                if (!await launchUrl(Uri.parse(url))) {
                  throw 'Could not launch $url';
                }
              },
            ),
          ],
        ),
        body: Center(
          child: SizedBox(
            width: 400.0,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextField(
                  maxLines: 3,
                  controller: _controller,
                ),
                const SizedBox(height: 60.0),
                CupertinoTextField(
                  maxLines: 3,
                  controller: _cupertinoController,
                ),
                const SizedBox(height: 20.0),
                CupertinoTextField(
                  maxLines: 3,
                  controller: _cupertinoControllerFixed,
                  contextMenuBuilder: (context, editableTextState) {
                    return AdaptiveTextSelectionToolbar.editableText(
                      editableTextState: editableTextState,
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                CupertinoTextField(
                  maxLines: 3,
                  controller: _cupertinoControllerForced,
                  contextMenuBuilder: (context, editableTextState) {
                    return DesktopTextSelectionToolbar(
                      anchor:
                          editableTextState.contextMenuAnchors.primaryAnchor,
                      children: AdaptiveTextSelectionToolbar.getAdaptiveButtons(
                        context,
                        editableTextState.contextMenuButtonItems,
                      ).toList(),
                    );
                  },
                ),
                const SizedBox(height: 60.0),
                Container(
                  color: Colors.white,
                  child: EditableText(
                    maxLines: 3,
                    controller: _editableController,
                    focusNode: FocusNode(),
                    style: Typography.material2021().black.displayMedium!,
                    cursorColor: Colors.blue,
                    backgroundCursorColor: Colors.white,
                    // contextMenuBuilder doesn't do anything here!
                    // EditableText has no built-in gesture detection for
                    // selection. A wrapper would have to implement
                    // TextSelectionGestureDetectorBuilderDelegate, etc.
                    contextMenuBuilder: (context, editableTextState) {
                      final TextEditingValue value =
                          editableTextState.textEditingValue;
                      final List<ContextMenuButtonItem> buttonItems =
                          editableTextState.contextMenuButtonItems;
                      return AdaptiveTextSelectionToolbar.editableText(
                        editableTextState: editableTextState,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
