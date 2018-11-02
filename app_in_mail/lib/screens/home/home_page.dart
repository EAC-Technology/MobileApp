import 'package:app_in_mail/blocs/emails_bloc.dart';
import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/model/email.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/screens/home/email_list.dart';
import 'package:app_in_mail/screens/home/email_types_list.dart';
import 'package:app_in_mail/screens/login/login_screen.dart';
import 'package:app_in_mail/screens/menu/menu.dart';
import 'package:app_in_mail/screens/menu/side_drawer.dart';
import 'package:app_in_mail/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:app_in_mail/custom_widgets/collapsible_header_container.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_in_mail/custom_widgets/appinmail_textfield.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearchCollapsed = true;

  final TextEditingController _searchTextFieldController =
      TextEditingController();

  AppInMailBloc _appInMailBloc;
  @override
  void initState() {
    super.initState();
    if (RestApiClient.needsLogin()) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _navigateToLogin());
    }
  }

  //todo change the SideDrawer to single page
  @override
  Widget build(BuildContext context) {
    _appInMailBloc = AppInMailBlocProvider.of(context);

    return new Scaffold(
        drawer: SideDrawer(),
        appBar: !RestApiClient.needsLogin() ? buildAppBar() : null,
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          )),
          child: Icon(
            Icons.add,
            size: 40.0,
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return EmailTypesListScreen();
            }));
          },
        ),
        body: CollapsibleHeaderContainer(
            isHeaderCollapsed: this._isSearchCollapsed,
            header: _buildSearchBox(),
            headerHeight: 100.0,
            child: EmailList(
              isSearchCollapsed: this._isSearchCollapsed,
              searchText: _searchTextFieldController.text,
            )));
  }

  dynamic _onClearSearchPressed() {
    setState(() {
      this._isSearchCollapsed = !this._isSearchCollapsed;
    });
  }

  Widget _buildSearchBox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: this._onClearSearchPressed,
        ),
        Expanded(
          child: Container(
              width: 100.0,
              child: AppInMailTextField(
                onChanged: (text) {
                  setState(() {
                    _appInMailBloc.emailsEmailsSearch
                        .add(EmailsSearch(searchText: text));
                  });
                },
                controller: _searchTextFieldController,
                keyboardType: TextInputType.text,
              )),
        ),
        Container(
          width: 20.0,
        ) //right padding
      ],
    );
  }

  void _navigateToLogin() {
    Log.d("no saved user, redirect to Login screen");
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new LoginScreen();
        },
      ),
    );
  }

  void _showMenu() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return Menu();
    }));
  }

  AppBar buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      title: new Text(
        Localization.getString(Strings.inbox),
        style: TextStyle(
            color: AppColors.titleTextColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ),
      elevation: 0.5,
      leading: Builder(
        builder: (context) {
          return IconButton(
              icon: SvgPicture.asset(
                Img.icMenu,
                width: 22.0,
                height: 18.0,
              ),
              onPressed: () =>
                  _showMenu()); //Scaffold.of(context).openDrawer());
        },
      ),
      actions: <Widget>[
        InkWell(
          child: Row(
            children: <Widget>[
              StreamBuilder<List<Email>>(
                stream: _appInMailBloc.emails,
                builder: (context, snapshot) => new Text(
                      snapshot.data.length.toString(),
                      style: TextStyle(
                          color: AppColors.accentColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SvgPicture.asset(
                  Img.icDot,
                  width: 8.0,
                  height: 8.0,
                ),
              ),
            ],
          ),
        ),
        IconButton(
            icon: SvgPicture.asset(
              Img.icSearch,
              width: 18.0,
              height: 18.0,
            ),
            onPressed: () {
              setState(() {
                _isSearchCollapsed = !_isSearchCollapsed;
              });
            }),
      ],
    );
  }
}
