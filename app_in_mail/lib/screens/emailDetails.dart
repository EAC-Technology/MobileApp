import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../restApi/restApiClient.dart';
import '../restApi/email.dart';

class EmailDetails extends StatefulWidget {
  EmailDetails({this.email, this.mailBox});

  final Email email;
  final String mailBox;

  @override
  EmailDetailsState createState() => new EmailDetailsState();
}

class EmailDetailsState extends State<EmailDetails> {
  FlutterWebviewPlugin webview;
  AppBar appBar = AppBar();
  var _emailUrl = "";
  @override
  void initState() {
    webview = FlutterWebviewPlugin();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadEmail());
  }

  void _loadEmail() async {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    _emailUrl = RestApiClient.buildEmailMobileViewerPageURL(
        widget.mailBox, widget.email.id);
    final verticalOffset =
        mediaQuery.padding.top + appBar.preferredSize.height + 10;
    
    webview.onStateChanged.listen(webStateChanged);
    setState(() {
          this._shouldDisplayProgressIndicator = true;
    });

    webview.launch(_emailUrl,
        withJavascript: true,
        withZoom: true,
        rect: Rect.fromLTWH(10.0, verticalOffset, width - 20.0,
            mediaQuery.size.height - verticalOffset));
    webview.hide();
  }

  void webStateChanged(WebViewStateChanged change){
    if (change.type.index == 2) { //if we have finsihed loading.
      setState(() {
          this._shouldDisplayProgressIndicator = false;
          webview.show();
      });
    }
  }

  bool _shouldDisplayProgressIndicator = false;
  Widget _getStandardBody() {
    return Center(
        child: Container(
      color: Colors.white,
    ));
  }

  Widget _getProgressIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getBody() {
    if (_shouldDisplayProgressIndicator) {
      return _getProgressIndicator();
    } else {
      return _getStandardBody();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text(widget.email.subject)), body: _getBody());
  }

  @override
  void dispose() {
    webview.close();
    webview.dispose();
    super.dispose();
  }
}
