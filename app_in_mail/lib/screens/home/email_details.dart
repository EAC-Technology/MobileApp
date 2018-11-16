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

class EmailDetailsState extends State<EmailDetails> {
  bool _isActionsHeaderCollapsed = true;
  AppBar appBar = AppBar();
  @override
  void initState() {
    super.initState();
  }


  bool _shouldDisplayProgressIndicator = false;
  Widget _getStandardBody() {
    return Column(children: <Widget>[
      Container(height: 150.0,  color: AppColors.accentColor,),
    ],);
  }

  Widget _getProgressIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getBody() {
    final mediaQuery = MediaQuery.of(context);
    var verticalOffset = mediaQuery.padding.top + appBar.preferredSize.height + 10;

    if (!_isActionsHeaderCollapsed) {
        verticalOffset += 160;
    }
    var webViewRect = Rect.fromLTWH(10.0, verticalOffset, mediaQuery.size.width,
            mediaQuery.size.height - verticalOffset);
        
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
    return new WebviewScaffold(
      appBar: _buildAppBar(),
      initialChild: _getProgressIndicator(),
      url:  widget.emailUrl,
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      title: new Text(
        " ",//TODO: render subject here.
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
    super.dispose();
  }
}
