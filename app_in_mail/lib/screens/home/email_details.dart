import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/custom_widgets/collapsible_header_container.dart';
import 'package:app_in_mail/model/email.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/utils/alertHelper.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class EmailDetails extends StatefulWidget {
  EmailDetails({this.email, this.mailBox});

  final Email email;
  final String mailBox;

  @override
  EmailDetailsState createState() => new EmailDetailsState();
}

class EmailDetailsState extends State<EmailDetails> {
  bool _isActionsHeaderCollapsed = true;
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
    _emailUrl = await RestApiClient.buildEmailMobileViewerPageURL(
        widget.mailBox, widget.email.id);
    final verticalOffset =
        mediaQuery.padding.top + appBar.preferredSize.height + 10;

    webview.onStateChanged.listen(webStateChanged);
    setState(() {
      this._shouldDisplayProgressIndicator = true;
    });

    webview.launch(_emailUrl,
        withJavascript: true,
        withZoom: false,
        rect: Rect.fromLTWH(10.0, verticalOffset, mediaQuery.size.width,
            mediaQuery.size.height - verticalOffset));
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
            Container(height: 20,),
            GestureDetector(child: Text(Localization.getString(Strings.moveTo), style: TextStyle(color: AppColors.titleTextColor, fontSize: 16 ),), onTap: (){
              AlertHelper.showSnackBar(context, "TBI");
            },),
            Container(height: 20,),
            GestureDetector(child: Text(Localization.getString(Strings.markAsUnread), style: TextStyle(color: AppColors.titleTextColor, fontSize: 16 ),), onTap: (){
              AlertHelper.showSnackBar(context, "TBI");
            },),
            Container(height: 20,),
            GestureDetector(child: Text(Localization.getString(Strings.delete), style: TextStyle(color: AppColors.titleTextColor, fontSize: 16 ),), onTap: (){
              AlertHelper.showSnackBar(context, "TBI");
            },),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body: _getBody(),
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      title: new Text(
        widget.email.subject,
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
          onPressed: () => Navigator.of(context).pop()),
      actions: <Widget>[
        IconButton(
            icon:  Icon(
              _isActionsHeaderCollapsed?Icons.more_horiz: Icons.clear,
              color: AppColors.titleTextColor,
              size: 28,
            ),
            onPressed: () {
              setState(() {
                _isActionsHeaderCollapsed = !_isActionsHeaderCollapsed;
              });
            }),
      ],
    );
  }

  @override
  void dispose() {
    webview.close();
    webview.dispose();
    super.dispose();
  }
}
