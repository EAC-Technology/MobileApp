import 'package:app_in_mail/model/email.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/screens/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_in_mail/screens/home/emailDetails.dart';
import 'package:app_in_mail/screens/home/emailCell.dart';
import 'package:app_in_mail/utils/alertHelper.dart';
import 'package:app_in_mail/utils/localization.dart';

class EmailList extends StatefulWidget {
  EmailList({Key key, this.title}) : super(key: key);

  final String title;
  @override
  EmailListState createState() => new EmailListState();
}

class EmailListState extends State<EmailList> {
  List<Email> _emails = List<Email>();
  String _mailBox;
  @override
  void initState() {
    super.initState();
    if (RestApiClient.needsLogin()) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _navigateToLogin());
    }else {
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
    AlertHelper.showErrorMessage(context, Localization.getText('error_while_getting_emails_list'), error.toString());
  }

  void _loadData() async {
    setState(() {
      _shouldDisplayProgressIndicator = true;
    });

    final mailBoxes = await RestApiClient.getMailboxesList().catchError(_onError);
    _mailBox = mailBoxes
        .first; 
    this._emails = await RestApiClient.getEmailsList(_mailBox).catchError(_onError);

    setState(() {
      _shouldDisplayProgressIndicator = false;
    });
  }

  Widget _buildListRow(int index) {
    //return Text('asdfasdf');
    return GestureDetector(
      onTap: () {
        _navigateToEmail(index);
      },
      child: Column(children: <Widget>[
        EmailCell(email: _emails[index]),
        Container(height: 10.0) //spacer
      ]),
    );
  }

  void _navigateToEmail(int index) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return EmailDetails(mailBox: _mailBox, email: _emails[index]);
        },
      ),
    );
  }

  Widget _buildEmailsList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          if (index < _emails.length) {
            return _buildListRow(index);
          }
        });
  }

  bool _shouldDisplayProgressIndicator = false;
  Widget _getStandardBody() {
    return Container(color: Colors.white, child: _buildEmailsList());
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
