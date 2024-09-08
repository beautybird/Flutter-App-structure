import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/src/google_map/map_location_provider.dart';
import 'package:flutterapp/src/google_map/places_result_provider.dart';
import 'package:flutterapp/src/gorouter/routing_conf/routings.dart';
import 'package:flutterapp/src/parallax/card_provider.dart';
import 'package:flutterapp/src/providers/category_type.dart';
import 'package:flutterapp/src/providers/country_city_provider.dart';
import 'package:flutterapp/src/providers/locale_provider.dart';
import 'package:flutterapp/src/providers/products_search_provider.dart';
import 'package:flutterapp/src/providers/search_result_provider.dart';
import 'package:flutterapp/src/providers/selected_currency.dart';
import 'package:flutterapp/src/shared_widgets/phone_number_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:provider/provider.dart';

import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    this.settingsController,
  });

  final SettingsController? settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController!,
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
            ChangeNotifierProvider<CountryCityProvider>(
              create: (context) => CountryCityProvider(),
            ),
            ChangeNotifierProvider<SearchResultProvider>(
              create: (context) => SearchResultProvider(),
            ),
            ChangeNotifierProvider<SelectedCategoryProvider>(
              create: (context) => SelectedCategoryProvider(),
            ),
            ChangeNotifierProvider<CompanyLocationProvider>(
              create: (context) => CompanyLocationProvider(),
            ),
            ChangeNotifierProvider<PlaceResultsProvider>(
              create: (context) => PlaceResultsProvider(),
            ),
            ChangeNotifierProvider<SearchToggleProvider>(
              create: (context) => SearchToggleProvider(),
            ),
            ChangeNotifierProvider<PhoneNumberProvider>(
              create: (context) => PhoneNumberProvider(),
            ),
            ChangeNotifierProvider<CardProvider>(
              create: (context) => CardProvider(),
            ),
            ChangeNotifierProvider<ProductsSearchProvider>(
              create: (context) => ProductsSearchProvider(),
            ),
            ChangeNotifierProvider<SelectedCurrencyProvider>(
              create: (context) => SelectedCurrencyProvider(),
            ),
            /* ChangeNotifierProvider<CheckoutProvider>(
              create: (context)=> CheckoutProvider(),
            ),
            ChangeNotifierProvider<VideoProvider>(
              create: (context)=> VideoProvider(),
            ),*/
          ],
          /*builder: (context,child){

          },*/
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            // Wrapping the app with a builder method makes breakpoints
            // accessible throughout the widget tree.
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',

            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            //
            // The appTitle is defined in .arb files found in the localization
            // directory.
            /*onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,*/

            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // SettingsController to display the correct theme.
            theme: ThemeData(useMaterial3: true),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController!.themeMode,
            //Using GoRouter
            //routeInformationParser: AppRouting().routes.routeInformationParser,
            //routerDelegate: AppRouting().routes.routerDelegate,
            //routeInformationProvider: AppRouting().routes.routeInformationProvider,
            routerConfig: goRouter,
          ),
        );
      },
    );
  }
}
