import 'package:app_in_mail/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class EwalletWebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  EwalletWebViewScreen({this.url, this.title});

  @override
  _EwalletWebViewScreenState createState() => _EwalletWebViewScreenState();
}

Widget _getProgressIndicator() {
  return Center(child: CircularProgressIndicator());
}

class _EwalletWebViewScreenState extends State<EwalletWebViewScreen> {
  AppBar appBar = AppBar();
  bool _shouldDisplayProgressIndicator = false;
  final webview = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadContent());
  }

  void _loadContent() async {
    webview.onStateChanged.listen(webStateChanged);
    setState(() {
      this._shouldDisplayProgressIndicator = true;
    });
    webview.launch(widget.url,
        withJavascript: true, withZoom: false, rect: _webviewRect());
    webview.hide();
  }

  void webStateChanged(WebViewStateChanged change) {
    if (change.type == WebViewState.finishLoad) {
      //if we have finsihed loading.
      setState(() {
        this._shouldDisplayProgressIndicator = false;
        webview.show();
      });
    }
  }

  Rect _webviewRect() {
    final mediaQuery = MediaQuery.of(context);
    var padding = 20.0;
    final verticalOffset = mediaQuery.padding.top +
        appBar.preferredSize.height;
    var webViewRect = Rect.fromLTWH(
        padding,
        verticalOffset + padding,
        mediaQuery.size.width - padding * 2,
        mediaQuery.size.height - verticalOffset);
    return webViewRect;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _shouldDisplayProgressIndicator
          ? _getProgressIndicator()
          : Container(),
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      title: new Text(
        widget.title,
        style: TextStyle(
            color: AppColors.titleTextColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ),
      elevation: 0.5,
      leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: AppColors.titleTextColor,
            size: 32.0,
          ),
          onPressed: () {
            webview.close();
            Navigator.of(context).pop();
          }),
    );
  }

  @override
  void dispose() {
    webview.dispose();
    super.dispose();
  }
}
