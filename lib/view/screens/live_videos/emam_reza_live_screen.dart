import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..loadRequest(Uri.parse('https://telewebion.com/live/razavi'));
      ..loadRequest(Uri.parse('https://kanal12.net/canliyayin'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('İmam Rıza Türbesi Canlı Yayın')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
