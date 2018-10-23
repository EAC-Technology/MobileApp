import 'package:app_in_mail/blocs/emails_bloc.dart';
import 'package:app_in_mail/model/email.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/screens/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_in_mail/screens/home/emailDetails.dart';
import 'package:app_in_mail/screens/home/emailCell.dart';
import 'package:app_in_mail/utils/alertHelper.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';

class EmailList extends StatefulWidget {
  final bool isSearchCollapsed;
  EmailList({Key key, this.title, this.isSearchCollapsed, this.searchText})
      : super(key: key);

  final String title;
  final String searchText;
  @override
  EmailListState createState() => new EmailListState();
}

class EmailListState extends State<EmailList> {
  String _mailBox;
  @override
  void initState() {
    super.initState();

    _redirectToLoginIfNeeded();
  }

  void _redirectToLoginIfNeeded() {
    if (RestApiClient.needsLogin()) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _navigateToLogin());
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new LoginScreen();
        },
      ),
    );
  }

  void _onError(error) {
    setState(() {
      _shouldDisplayProgressIndicator = false;
    });
    AlertHelper.showErrorMessage(
        context,
        Localization.getString(Strings.errorWhileGettingEmailsList),
        error.toString());
  }

  List<String> _mailBoxes = List<String>();

  void _loadData() async {
    var appInMailBloc = AppInMailBlocProvider.of(context);
    this._mailBoxes =
        await RestApiClient.getMailboxesList().catchError(_onError);
    var firstMailBox = _mailBoxes
        .first; //TODO: use selected mailbox instead of first. Implement in the Bloc , not here
    appInMailBloc.emailsDownload.add(EmailsDownload(mailBox: firstMailBox));
  }

  Widget _buildListRow(Email email) {
    return GestureDetector(
      onTap: () {
        _navigateToEmail(email);
      },
      child: Column(children: <Widget>[
        EmailCell(email: email),
        Divider(),
      ]),
    );
  }

  void _navigateToEmail(Email email) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return EmailDetails(mailBox: _mailBox, email: email);
        },
      ),
    );
  }

  Widget _buildEmailsList(List<Email> emails) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: emails.length,
        itemBuilder: (context, index) {
          return _buildListRow(emails[index]);
        });
  }

  bool _shouldDisplayProgressIndicator = false;
  Widget _getStandardBody() {
    var appInMailBloc = AppInMailBlocProvider.of(context);
    return Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: appInMailBloc.emails,
          builder: (context, snapshot) {
            return _buildEmailsList(snapshot.data);
          },
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

  Widget build(BuildContext context) {
    return _getBody();
  }
}
