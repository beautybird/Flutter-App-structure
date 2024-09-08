import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/src/parallax/card_provider.dart';
import 'package:flutterapp/src/parallax/images_card.dart';
import 'package:flutterapp/src/parallax/media_assets.dart';
import 'package:flutterapp/src/providers/products_search_provider.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:flutterapp/src/shared_widgets/buttons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Cards extends StatefulWidget {
  static const routeName = "/cardsRoute";
  final SettingsController? controller;
  final String? label;

  const Cards({super.key, this.controller, this.label});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  late PageController? _pageController;

  //
  CardProvider? cardProvider;
  //
  ProductsSearchProvider? productsSearchProvider;
  //
  Locale? _locale;
  //
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    cardProvider = Provider.of<CardProvider>(context);
    //
    productsSearchProvider = Provider.of<ProductsSearchProvider>(context);
    //
    _locale = EasyLocalization.of(context)!.currentLocale;
    //
    double? height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: MediaAssets.images.length,
              reverse: false,
              itemBuilder: (context, index) {
                return StandardElevatedButton(
                  autofocus: false,
                  buttonMinWidth: double.maxFinite,
                  buttonMaxWidth: double.maxFinite,
                  buttonMinHeight: height * 0.82,
                  buttonMaxHeight: height * 0.82,
                  backgroundBaseColor: Colors.white,
                  foregroundBaseColor: Colors.white,
                  buttonShape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                  elevation: 15.0,
                  padding: 0.0,
                  shadowColor: Colors.grey,
                  onFocusChanged: (value) {},
                  onHover: (value) {},
                  child: Stack(
                    children: [
                      ImagesCard(),
                      Positioned(
                        left: 100.0,
                        width: 150.0,
                        top: MediaQuery.of(context).size.height * 0.79,
                        height: 70.0,
                        child: categoryTextColor(index, _locale)!,
                      ),
                    ],
                  ),
                  onPressed: () {
                    ///When any image clicked...will redirect to corresponding
                    ///category page
                    if (cardProvider!.mediaIndex == 0 ||
                        cardProvider!.mediaIndex == null) {
                      fetchCategoryData('honey');
                    } else if (cardProvider!.mediaIndex == 1) {
                      fetchCategoryData('drink');
                    } else if (cardProvider!.mediaIndex == 2) {
                      fetchCategoryData('skin');
                    } else if (cardProvider!.mediaIndex == 3) {
                      fetchCategoryData('makeup');
                    } else {
                      fetchCategoryData('perfume');
                    }
                  },
                );
              },
              onPageChanged: (i) {
                cardProvider!.setMediaIndex(i);
                cardProvider!.setAssetPath(MediaAssets.images[i]);
                cardProvider!.setIsSelected(true);
                cardProvider!.setCategory('');
                cardProvider!.setCategory(MediaAssets.categories[i]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget? categoryColor;
  Widget? categoryTextColor(int? index, Locale? selectedLocale) {
    //
    if (selectedLocale!.languageCode.contains('en')) {
      if (index == 1) {
        return AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              MediaAssets.categories[index!],
              textStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      } else {
        return AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              MediaAssets.categories[index!],
              textStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
    } else {
      if (index == 1) {
        return AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              MediaAssets.categoriesAr[index!],
              textStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      } else {
        return AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              MediaAssets.categoriesAr[index!],
              textStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
    }
  }

  void fetchCategoryData(String? category) async {
    try {
      await supabaseClient
          .from('products')
          .select()
          .eq('category', category!)
          .then((value) {
        if (value.isNotEmpty) {
          //
          ///We empty the content of the provider from previous searches
          productsSearchProvider!.setProductsSearchList([]);

          ///We load the result of the new search
          productsSearchProvider!.setProductsSearchList(value);
          //Pass the category for the add item & buy checkout
          productsSearchProvider!.setCategory('');
          productsSearchProvider!.setCategory(category);
          //
          context.go('/a/homeScreenRoute');
        } else {
          //
          productsSearchProvider!.setProductsSearchList([]);
          context.go('/a/noProductsRoute');
        }
      }).onError((error, stackTrace) {
        setState(() {
          Flushbar(
            duration: Duration(seconds: 5),
            title: 'generalUse-sorry'.tr().toString(),
            titleColor: Colors.red,
            titleSize: 20.0,
            message: 'error'.tr().toString(),
            messageColor: Colors.black,
            messageSize: 16.0,
            messageText: Text('generalUse-error'.tr().toString()),
            titleText: Text(
              'generalUse-sorry'.tr().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 20.0,
              ),
            ),
            icon: Icon(
              Icons.error,
              color: Colors.red,
              size: 20.0,
            ),
            shouldIconPulse: true,
            maxWidth: 300.0,
            margin: EdgeInsets.only(top: 300.0),
            padding: EdgeInsets.all(3.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderColor: Colors.black,
            borderWidth: 1.0,
            backgroundColor: Colors.grey.shade300,
            mainButton: Text(''),
            onTap: (value) {},
            isDismissible: true,
            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
            flushbarPosition: FlushbarPosition.TOP,
            positionOffset: 0.0,
            flushbarStyle: FlushbarStyle.FLOATING,
          )..show(context);
        });
      }).whenComplete(() => null);
      //
    } catch (exc) {
      setState(() {
        Flushbar(
          duration: Duration(seconds: 5),
          title: 'generalUse-sorry'.tr().toString(),
          titleColor: Colors.red,
          titleSize: 20.0,
          message: 'generalUse-error'.tr().toString(),
          messageColor: Colors.black,
          messageSize: 16.0,
          messageText: Text('generalUse-error'.tr().toString()),
          titleText: Text(
            'generalUse-sorry'.tr().toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 20.0,
            ),
          ),
          icon: Icon(
            Icons.error,
            color: Colors.red,
            size: 20.0,
          ),
          shouldIconPulse: true,
          maxWidth: 300.0,
          margin: EdgeInsets.only(top: 300.0),
          padding: EdgeInsets.all(3.0),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderColor: Colors.black,
          borderWidth: 1.0,
          backgroundColor: Colors.grey.shade300,
          mainButton: Text(''),
          onTap: (value) {},
          isDismissible: true,
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 0.0,
          flushbarStyle: FlushbarStyle.FLOATING,
        )..show(context);
      });
      exc.toString();
    }
  }
}
