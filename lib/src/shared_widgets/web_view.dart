
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

/*For Android, you will need to update your AndroidManifest. xml.
See https:// developer. android. com/ training/ permissions/ declaring
For iOS, you will need to update your Info. plist. See https:// developer. apple. com/ documentation/ uikit/ protecting_the_user_s_privacy/ requesting_access_to_protected_resources?language=objc . {@endtemplate}
See WebViewController. fromPlatformCreationParams for setting parameters for a specific platform.*/

class WebviewPage extends StatefulWidget {
  final String? videoAddress;
  const WebviewPage({super.key, this.videoAddress});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  //
  late final WebViewController _controller;
  var loadingPercentage = 0;
  WebViewController? controller;
  //
  @override
  void initState() {
    super.initState();
    if (widget.videoAddress!.isNotEmpty) {
      // #docregion platform_features
      late final PlatformWebViewControllerCreationParams params;
      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: false,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
        );
      } else {
        params = const PlatformWebViewControllerCreationParams();
      }

      controller = WebViewController.fromPlatformCreationParams(params);
      // #enddocregion platform_features

      controller!
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              debugPrint('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              debugPrint('Page started loading: $url');
            },
            onPageFinished: (String url) {
              debugPrint('Page finished loading: $url');
            },
            onWebResourceError: (WebResourceError error) {
              debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
            },
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.vimeo.com/')) {
                debugPrint('blocking navigation to ${request.url}');
                return NavigationDecision.prevent;
              }
              debugPrint('allowing navigation to ${request.url}');
              return NavigationDecision.navigate;
            },
            onUrlChange: (UrlChange change) {
              debugPrint('url change to ${change.url}');
            },
            onHttpAuthRequest: (HttpAuthRequest request) {
              //openDialog(request);
            },
          ),
        )
        ..addJavaScriptChannel(
          'Toaster',
          onMessageReceived: (JavaScriptMessage message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message.message)),
            );
          },
        )
        ..loadRequest(Uri.parse('${widget.videoAddress}'));

      // #docregion platform_features
      if (controller!.platform is AndroidWebViewController) {
        AndroidWebViewController.enableDebugging(true);
        (controller!.platform as AndroidWebViewController)
            .setMediaPlaybackRequiresUserGesture(false);
      }
      // #enddocregion platform_features

      _controller = controller!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videoAddress!.isEmpty || widget.videoAddress == null) {
      return Image(
        image: AssetImage('assets/images/noVideoAvailable.png'),
      );
    } else {
      return Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      );
    }
  }
}
