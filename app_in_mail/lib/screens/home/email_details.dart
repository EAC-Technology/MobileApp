import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/custom_widgets/collapsible_header_container.dart';
import 'package:app_in_mail/utils/alert_helper.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class EmailDetails extends StatefulWidget {
  EmailDetails({this.emailUrl});
  final String emailUrl;

  @override
  EmailDetailsState createState() => new EmailDetailsState();
}

class EmailDetailsState extends State<EmailDetails>
    with SingleTickerProviderStateMixin {
  bool _isActionsHeaderCollapsed = true;
  final webview = new FlutterWebviewPlugin();
  Animation<double> animation;
  AnimationController controller;
  AppBar appBar = AppBar();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadEmail());

    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween(begin: 0.0, end: 160.0).animate(curve)
      ..addListener(() {
        webview.resize(_webviewRect());
      });
  }

  Rect _webviewRect() {
    final mediaQuery = MediaQuery.of(context);
    var padding = 20.0;
    final verticalOffset = mediaQuery.padding.top +
        appBar.preferredSize.height +
        40 +
        animation.value;
    var webViewRect = Rect.fromLTWH(
        20,
        verticalOffset + padding,
        mediaQuery.size.width * mediaQuery.devicePixelRatio * 0.8,
        mediaQuery.size.height * mediaQuery.devicePixelRatio * 0.8);
    return webViewRect;
  }

  void _loadEmail() async {
    
    webview.onStateChanged.listen(webStateChanged);
    setState(() {
      this._shouldDisplayProgressIndicator = true;
    });
    webview.launch(widget.emailUrl,
        withJavascript: true,
        withZoom: false,
        rect: _webviewRect());
    webview.hide();
  }

  void webStateChanged(WebViewStateChanged change) {
    if (change.type.index == 2) {
      //if we have finsihed loading.
      setState(() {
        this._shouldDisplayProgressIndicator = false;
        webview.show();
      });
    }
  }

  // void _loadEmail() {

  //   flutterWebviewPlugin.launch(
  //     "http://www.google.com",
  //     rect: new Rect.fromLTWH(
  //       0.0,
  //       0.0,
  //       300,
  //       600.0,
  //     ),
  //   );
  // }

  bool _shouldDisplayProgressIndicator = false;
  Widget _getStandardBody() {
    return Column(
      children: <Widget>[
        Container(),
      ],
    );
  }

  Widget _getProgressIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getBody() {
    final mediaQuery = MediaQuery.of(context);
    var verticalOffset =
        mediaQuery.padding.top + appBar.preferredSize.height + 40;

    if (!_isActionsHeaderCollapsed) {
      verticalOffset += 160;
    }
    var padding = 20.0;
    var webViewRect = Rect.fromLTWH(
        padding,
        verticalOffset + padding,
        mediaQuery.size.width - padding * 2,
        mediaQuery.size.height - verticalOffset);
    //webview.resize(webViewRect);

    return CollapsibleHeaderContainer(
        isHeaderCollapsed: this._isActionsHeaderCollapsed,
        header: _buildEmailActionSheet(),
        headerHeight: 160.0,
        child: _shouldDisplayProgressIndicator
            ? _getProgressIndicator()
            : _getStandardBody());
  }

  Widget _buildEmailActionSheet() {
    return Row(
      children: <Widget>[
        Container(
          width: 50,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20,
            ),
            GestureDetector(
              child: Text(
                Localization.getString(Strings.moveTo),
                style: TextStyle(color: AppColors.titleTextColor, fontSize: 16),
              ),
              onTap: () {
                AlertHelper.showSnackBar(context, "TBI");
              },
            ),
            Container(
              height: 20,
            ),
            GestureDetector(
              child: Text(
                Localization.getString(Strings.markAsUnread),
                style: TextStyle(color: AppColors.titleTextColor, fontSize: 16),
              ),
              onTap: () {
                AlertHelper.showSnackBar(context, "TBI");
              },
            ),
            Container(
              height: 20,
            ),
            GestureDetector(
              child: Text(
                Localization.getString(Strings.delete),
                style: TextStyle(color: AppColors.titleTextColor, fontSize: 16),
              ),
              onTap: () {
                AlertHelper.showSnackBar(context, "TBI");
              },
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _shouldDisplayProgressIndicator
          ? _getProgressIndicator()
          : _getBody(),
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      title: new Text(
        " ", //TODO: render subject here.
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
      actions: <Widget>[
        IconButton(
            icon: Icon(
              _isActionsHeaderCollapsed ? Icons.more_horiz : Icons.clear,
              color: AppColors.titleTextColor,
              size: 28,
            ),
            onPressed: () {
              setState(() {
                _isActionsHeaderCollapsed = !_isActionsHeaderCollapsed;
                if (_isActionsHeaderCollapsed) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
              });
            }),
      ],
    );
  }

  @override
  void dispose() {
    webview.dispose();
    super.dispose();
  }
}
