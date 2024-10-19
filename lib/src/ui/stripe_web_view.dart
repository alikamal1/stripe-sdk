import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeWebView extends StatelessWidget {
  StripeWebView({Key? key, required this.uri, required this.returnUri})
      : super(key: key);

  final String uri;
  final Uri returnUri;

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (String url) {
              final uri = Uri.parse(url);
              if (uri.scheme == returnUri.scheme &&
                  uri.host == returnUri.host &&
                  uri.queryParameters['requestId'] ==
                      returnUri.queryParameters['requestId']) {
                Navigator.pop(context, true);
              }
            },
          ),
        )
        ..loadRequest(Uri.parse(uri)),
    );
  }
}
