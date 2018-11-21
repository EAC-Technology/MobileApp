import 'dart:async';

import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class EwalletWebViewScreen extends StatefulWidget {
  final Map<String, String> eWalletOperation;
  EwalletWebViewScreen({this.eWalletOperation});

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

  Timer pollingTimer;
  void _startPollingTimer() {
    const duration = Duration(seconds: 2);
    this.pollingTimer = Timer(duration, _pollTransactionState);
  }

  void _pollTransactionState() async {
    print('Polling for transaction id:' + this.transactionId);
    var status =
        await RestApiClient.pollWalletOperationStatus(this.transactionId)
            .catchError((error) {
      print(error);
    });
    print(status);
    //_startPollingTimer();
  }

  String transactionId;
  void _loadContent() async {
    this.transactionId = await RestApiClient.preauthWalletOperation(
        widget.eWalletOperation['operation']);
    print('TransactionId after preauth:' + this.transactionId);
    final webViewUrl =
        RestApiClient.getOperationTransactionUrl(this.transactionId);
    webview.onStateChanged.listen(webStateChanged);
    setState(() {
      this._shouldDisplayProgressIndicator = true;
    });
    this._startPollingTimer();
    final rect = _webviewRect();
    print(rect);
    webview.launch(webViewUrl,
        withJavascript: true, withZoom: true, rect: rect);
    webview.hide();
  }

  void webStateChanged(WebViewStateChanged change) {
    print('url changed to :' + change.url);
    if (change.type == WebViewState.finishLoad) {
      setState(() {
        this._shouldDisplayProgressIndicator = false;
        webview.show();
      });
    }
  }

  Rect _webviewRect() {
    final mediaQuery = MediaQuery.of(context);
    var padding = 20.0;
    final verticalOffset = mediaQuery.padding.top + appBar.preferredSize.height;
    var webViewRect = Rect.fromLTWH(
        0,
        verticalOffset + padding,
        mediaQuery.size.width * mediaQuery.devicePixelRatio * 0.8,
        mediaQuery.size.height * mediaQuery.devicePixelRatio * 0.8);
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
        widget.eWalletOperation['title'],
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
