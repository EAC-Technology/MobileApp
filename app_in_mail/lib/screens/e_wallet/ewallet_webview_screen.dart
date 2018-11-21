import 'dart:async';

import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/screens/ewallet_success_screen.dart';
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
    const duration = Duration(seconds: 1);
    this.pollingTimer = Timer(duration, _pollTransactionState);
  }

  void _pollTransactionState() async {
    print('Polling for transaction id:' + this.secondaryTransactionId);
    var status = await RestApiClient.pollWalletOperationStatus(
            this.secondaryTransactionId)
        .catchError((error) {
      print(error);
    });
    print(status);
    if (status == 'OPERATION CREATED') {
      _onOperationCreated();
      this._startPollingTimer();
    } else if (status == 'OPERATION SUCCEEDED') {
      _onOperationSucceeded();
    }
  }

  void _onOperationCreated() {
    setState(() {
      this.webview.hide();
      this._shouldDisplayProgressIndicator = true;
    });
  }

  void _onOperationSucceeded() {
    setState(() {
      this._shouldDisplayProgressIndicator = false;
      this._showSuccess();
    });
  }

  void _showSuccess() {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return EwalletSuccessScreen(title: widget.eWalletOperation['title'],);
        },
      ),
    );
  }

  String transactionId; //this one we use to load the webview.
  String secondaryTransactionId; //this one is for the real operation
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
    final rect = _webviewRect();
    print(rect);
    webview.launch(webViewUrl,
        withJavascript: true, withZoom: true, rect: rect);
    webview.hide();
  }

  void webStateChanged(WebViewStateChanged change) async {
    // What follows is black magic. Only two people in the world know how it works
    // Only one knows what it does :(.
    // Be scared!!!
    // Kidding ...here is the deal: For some reason the transaction id from the preauth phase is not the same as the real transaction id :|.
    // Because we do not have API to get the real one we do this:
    // 1.Inject javascript to get the html body of the document inside the webview.
    // 2.Find some javascript that is server generated and has the real transaction id in it.
    // 3.Be ashamed of that code big time :(.

    if (change.type == WebViewState.finishLoad) {
      var document =
          await webview.evalJavascript('document.documentElement.outerHTML');
      RegExp regExp = new RegExp(
          'transaction_id:"(\{{0,1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\}{0,1})"',
          caseSensitive: false);
      var match = regExp.stringMatch(document);

      if (match != null) {
        this.secondaryTransactionId =
            match.replaceAll('transaction_id:"', '').replaceAll('"', '');
        this._startPollingTimer();
      }

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
    var webViewRect = Rect.fromLTWH(padding, verticalOffset + padding,
        mediaQuery.size.width - padding * 2, mediaQuery.size.height);
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
