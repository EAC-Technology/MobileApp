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
  EmailList({Key key, this.title, this.isSearchCollapsed, this.searchText}) : super(key: key);

  final String title;
  final String searchText;
  @override
  EmailListState createState() => new EmailListState();
}

class EmailListState extends State<EmailList> {
  List<Email> _emails = List<Email>();
  List<Email> _filteredEmails = List<Email>();
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
    setState(() {
      _shouldDisplayProgressIndicator = true;
    });
    
    //todo: should not reload emails and boxes on each redraw. e.g. when we search we trigger redraw on each letter.
    //this bellow is a temporary hack to test search:
    if (_mailBoxes.isEmpty) {
      this._mailBoxes = await RestApiClient.getMailboxesList().catchError(_onError);
    }
    
    _mailBox =_mailBoxes.first;

    if (this._emails.isEmpty) {
      this._emails = await RestApiClient.getEmailsList(_mailBox).catchError(_onError);
    }
    
    this._filteredEmails = this._emails.where((email) => widget.searchText.isEmpty || email.fromName.toLowerCase().contains(widget.searchText.toLowerCase())).toList();

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
        EmailCell(email: _filteredEmails[index]),
        Container(height: 10.0) //spacer
      ]),
    );
  }

  void _navigateToEmail(int index) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return EmailDetails(mailBox: _mailBox, email: _filteredEmails[index]);
        },
      ),
    );
  }

  Widget _buildEmailsList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          if (index < _filteredEmails.length) {
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
