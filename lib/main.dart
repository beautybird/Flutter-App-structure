import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

  ///Supabase
  await Supabase.initialize(
    url: String.fromEnvironment("SUPABASEURL", defaultValue: ""),
    anonKey: String.fromEnvironment("SUPABASEKEY", defaultValue: ""),
    headers: {},
    realtimeClientOptions: RealtimeClientOptions(
      eventsPerSecond: 10,
      logLevel: RealtimeLogLevel.info,
    ),
    postgrestOptions: PostgrestClientOptions(
      schema: 'public',
    ),
    authOptions: FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
      autoRefreshToken: true,
      //pkceAsyncStorage: GotrueAsyncStorage(),
      //localStorage: LocalStorage(),
    ),
    storageOptions: const StorageClientOptions(
      retryAttempts: 10,
    ),
  );
  //httpClient: ,
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(
    EasyLocalization(
      path: 'lib/src/lang',
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('es', 'ES'),
        Locale('ar', 'AE'),
        Locale('hi', 'IN'),
      ],
      fallbackLocale: const Locale('en', 'US'),
      saveLocale: true,
      startLocale: const Locale('en', 'US'),
      // optional assetLoader default used is RootBundleAssetLoader which uses flutter's assetloader
      // install easy_localization_loader for enable custom loaders
      // assetLoader: RootBundleAssetLoader()
      // assetLoader: HttpAssetLoader()
      // assetLoader: FileAssetLoader()
      // assetLoader: CsvAssetLoader()
      // assetLoader: YamlAssetLoader() //multiple files
      // assetLoader: YamlSingleAssetLoader() //single file
      // assetLoader: XmlAssetLoader() //multiple files
      // assetLoader: XmlSingleAssetLoader() //single file
      // assetLoader: CodegenLoader()
      child: MyApp(settingsController: settingsController),
    ),
  );
}
// It's handy to then extract the Supabase client in a variable for later uses
final supabaseClient = Supabase.instance.client;
