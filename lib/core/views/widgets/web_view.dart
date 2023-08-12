import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  WebView({super.key});

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {

        },
        onPageFinished: (String url) {

        },
        onWebResourceError: (WebResourceError error) {

        },
        onNavigationRequest: (NavigationRequest request) {
          if (!request.url.startsWith('http://oliver.engqr.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('http://oliver.engqr.com/'));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: WebViewWidget(
                controller: controller
            )
        )
    );
  }
}
