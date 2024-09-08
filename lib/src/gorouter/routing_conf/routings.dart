import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/src/gorouter/routing_conf/nestedNAvigator.dart';
import 'package:flutterapp/src/parallax/cards.dart';
import 'package:flutterapp/src/routes/home_page.dart';
import 'package:flutterapp/src/settings/settings_view.dart';
import 'package:flutterapp/src/with_supabase/routes_supabase/profileForm.dart';
import 'package:flutterapp/src/with_supabase/routes_supabase/splash.dart';
import 'package:go_router/go_router.dart';

import '../../with_supabase/routes_supabase/contactus.dart';
import '../../with_supabase/routes_supabase/forgot_password.dart';
import '../../with_supabase/routes_supabase/login.dart';
import '../../with_supabase/routes_supabase/loginForm.dart';
import '../../with_supabase/routes_supabase/noproducts_page.dart';
import '../../with_supabase/routes_supabase/shareapp.dart';
import '../../with_supabase/routes_supabase/signup_page.dart';

// ignore: depend_on_referenced_packages

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorLoginKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorContactKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellD');
final _shellNavigatorSettingsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellE');

final goRouter = GoRouter(
  initialLocation: '/',
  //errorBuilder: (BuildContext context, GoRouterState state) => Home(),
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => NoTransitionPage(
        child: SplashPage(label: 'splash', detailsPath: '/cardsRoute'),
      ),
      routes: [
        GoRoute(
          path: 'cardsRoute',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const Cards(label: 'cards'),
        ),
      ],
    ),
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
                path: '/a',
                pageBuilder: (context, state) => NoTransitionPage(
                      child: Cards(),
                    ),
                routes: [
                  //Home Screen Route
                  GoRoute(
                    path: 'homePageRoute',
                    parentNavigatorKey: _shellNavigatorHomeKey,
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: HomeScreen(
                          label: 'homeScreen', detailsPath: '/a/homePageRoute'),
                    ),
                    routes: [
                      GoRoute(
                        path: 'homePageRoute',
                        parentNavigatorKey: _shellNavigatorHomeKey,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: HomePage(
                            label: 'homePageRoute',
                          ),
                        ),
                      ),
                      //Profile Form
                      GoRoute(
                        path: 'profileFormRoute',
                        parentNavigatorKey: _shellNavigatorHomeKey,
                        pageBuilder: (context, state) => const NoTransitionPage(
                          child: ProfileFormScreen(
                              label: 'a',
                              detailsPath:
                                  '/a/homeScreenRoute/profileFormRoute'),
                        ),
                        routes: [
                          GoRoute(
                            path: 'profileFormRoute',
                            parentNavigatorKey: _shellNavigatorHomeKey,
                            builder: (context, state) => ProfileForm(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //noProductsRoute
                  GoRoute(
                    path: 'noProductsRoute',
                    parentNavigatorKey: _shellNavigatorHomeKey,
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: NoProductsScreen(
                          label: 'noProducts',
                          detailsPath: '/a/noProductsRoute'),
                    ),
                    routes: [
                      GoRoute(
                        path: 'noProductsRoute',
                        parentNavigatorKey: _shellNavigatorHomeKey,
                        builder: (context, state) =>
                            const NoProductsPage(label: 'noProducts'),
                      ),
                    ],
                  ),
                  //Login addBuyButtonsLoginRoute
                  GoRoute(
                    path: 'addBuyButtonsLoginRoute',
                    parentNavigatorKey: _shellNavigatorHomeKey,
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: AddBuyButtonsLoginScreen(
                          label: 'addBuyButtons',
                          detailsPath: '/a/addBuyButtonsLoginRoute'),
                    ),
                    routes: [
                      GoRoute(
                        path: 'AddBuyButtonsLoginRoute',
                        parentNavigatorKey: _shellNavigatorHomeKey,
                        builder: (context, state) =>
                            const AddBuyButtonsLoginRoute(
                                label: 'AddBuyButtonsLoginRoute'),
                      ),
                    ],
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorLoginKey,
          routes: [
            //
            GoRoute(
              path: '/b',
              parentNavigatorKey: _shellNavigatorLoginKey,
              pageBuilder: (context, state) => NoTransitionPage(
                child: LoginForm(),
              ),
              routes: [
                //Profile Form
                GoRoute(
                  path: 'profileFormRoute',
                  parentNavigatorKey: _shellNavigatorLoginKey,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: ProfileFormScreen(
                        label: 'B', detailsPath: '/b/profileFormRoute'),
                  ),
                  routes: [
                    GoRoute(
                      path: 'profileFormRoute',
                      parentNavigatorKey: _shellNavigatorLoginKey,
                      builder: (context, state) => ProfileForm(),
                    ),
                  ],
                ),
                //Forgot password
                GoRoute(
                  path: 'forgotPasswordPage',
                  parentNavigatorKey: _shellNavigatorLoginKey,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: ForgotPasswordScreen(
                        label: 'B', detailsPath: '/b/forgotPasswordPage'),
                  ),
                  routes: [
                    GoRoute(
                      path: 'forgotPasswordPage',
                      parentNavigatorKey: _shellNavigatorLoginKey,
                      builder: (context, state) => ForgotPasswordPage(),
                    ),
                  ],
                ),
                //Signup Page
                GoRoute(
                  path: 'signupRoute',
                  parentNavigatorKey: _shellNavigatorLoginKey,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: SignupScreen(
                        label: 'signup', detailsPath: '/b/signupRoute'),
                  ),
                  routes: [
                    GoRoute(
                      path: 'signupRoute',
                      parentNavigatorKey: _shellNavigatorLoginKey,
                      builder: (context, state) => SignupPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorContactKey,
          routes: [
            // contactusRoute
            GoRoute(
              path: '/d',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ContactsRootScreen(
                    label: 'D', detailsPath: '/d/contactusRoute'),
              ),
              routes: [
                GoRoute(
                  path: 'contactusRoute',
                  builder: (context, state) => Contactus(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSettingsKey,
          routes: [
            //settings
            GoRoute(
              path: '/e',
              parentNavigatorKey: _shellNavigatorSettingsKey,
              pageBuilder: (context, state) => const NoTransitionPage(
                child:
                    SettingsRootScreen(label: 'E', detailsPath: '/e/settings'),
              ),
              routes: [
                GoRoute(
                  path: 'settings',
                  parentNavigatorKey: _shellNavigatorSettingsKey,
                  builder: (context, state) => SettingsView(),
                ),
                GoRoute(
                    path: 'shareappRoute',
                    parentNavigatorKey: _shellNavigatorSettingsKey,
                    pageBuilder: (context, state) => NoTransitionPage(
                          child: ShareappScreen(
                              label: 'E', detailsPath: '/e/shareappRoute'),
                        ),
                    routes: [
                      GoRoute(
                          path: 'shareappRoute',
                          parentNavigatorKey: _shellNavigatorSettingsKey,
                          builder: (contxt, state) => ShareApp()),
                    ]),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: [
          NavigationDestination(
              label: 'generalUse-home'.tr().toString(), icon: Icon(Icons.home)),
          NavigationDestination(
              label: 'generalUse-login'.tr().toString(),
              icon: Icon(Icons.login)),
          NavigationDestination(
              label: 'generalUse-contactUs'.tr().toString(),
              icon: Icon(Icons.contacts)),
          NavigationDestination(
              label: 'generalUse-settings'.tr().toString(),
              icon: Icon(Icons.settings)),
          //NavigationDestination(label: 'Account', icon: Icon(Icons.account_box)),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                  label: Text('generalUse-home'.tr().toString()),
                  icon: Icon(Icons.home)),
              NavigationRailDestination(
                label: Text('generalUse-login'.tr().toString()),
                icon: Icon(Icons.login),
              ),
              NavigationRailDestination(
                label: Text('generalUse-contactUs'.tr().toString()),
                icon: Icon(Icons.contacts),
              ),
              NavigationRailDestination(
                label: Text('generalUse-settings'.tr().toString()),
                icon: Icon(Icons.settings),
              ),
              /*NavigationRailDestination(
                label: Text('Account'),
                icon: Icon(Icons.account_box),
              ),*/
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
class ContactsRootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const ContactsRootScreen(
      {required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Contactus(),
          ),
        ],
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
class SettingsRootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const SettingsRootScreen(
      {required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: SettingsView(),
          ),
        ],
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
class HomeScreen extends StatelessWidget {
  /// Creates a RootScreen
  const HomeScreen({required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: HomePage(),
          ),
        ],
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
/*class ItemDetailsScreen extends StatelessWidget {
  /// Creates a RootScreen
  const ItemDetailsScreen(
      {required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: DetailsScreen(),
          ),
        ],
      ),
    );
  }
}*/

/// Widget for the root/initial pages in the bottom navigation bar.
class AddBuyButtonsLoginScreen extends StatelessWidget {
  /// Creates a RootScreen
  const AddBuyButtonsLoginScreen(
      {required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: AddBuyButtonsLoginRoute(),
          ),
        ],
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
/*class CheckoutRouteScreen extends StatelessWidget {
  /// Creates a RootScreen
  const CheckoutRouteScreen(
      {required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Checkout(),
          ),
        ],
      ),
    );
  }
}*/

/// Widget for the root/initial pages in the bottom navigation bar.
/*class PaypalScreen extends StatelessWidget {
  /// Creates a RootScreen
  const PaypalScreen({required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: PaypalPaymentPage(),
          ),
        ],
      ),
    );
  }
}*/

/// Widget for the root/initial pages in the bottom navigation bar.
class NoProductsScreen extends StatelessWidget {
  /// Creates a RootScreen
  const NoProductsScreen(
      {required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: NoProductsPage(),
          ),
        ],
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
class ForgotPasswordScreen extends StatelessWidget {
  /// Creates a RootScreen
  const ForgotPasswordScreen(
      {required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: ForgotPasswordPage(),
          ),
        ],
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
class ProfileFormScreen extends StatelessWidget {
  /// Creates a RootScreen
  const ProfileFormScreen(
      {required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: ProfileForm(),
          ),
        ],
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
/*class ProductFormScreen extends StatelessWidget {
  /// Creates a RootScreen
  const ProductFormScreen(
      {required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: ProductsFormRoute(),
          ),
        ],
      ),
    );
  }
}*/

/// Widget for the root/initial pages in the bottom navigation bar.
/*class BuyNowScreen extends StatelessWidget {
  /// Creates a RootScreen
  const BuyNowScreen(
      {required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: BuyNowPage(),
          ),
        ],
      ),
    );
  }
}*/

/// Widget for the root/initial pages in the bottom navigation bar.
class ShareappScreen extends StatelessWidget {
  /// Creates a RootScreen
  const ShareappScreen(
      {required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: ShareApp(),
          ),
        ],
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
class SignupScreen extends StatelessWidget {
  /// Creates a RootScreen
  const SignupScreen({required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String? label;

  /// The path to the detail page
  final String? detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: SignupPage(),
          ),
        ],
      ),
    );
  }
}
