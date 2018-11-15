import 'package:app_in_mail/blocs/emails_bloc.dart';
import 'package:app_in_mail/model/email.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/screens/home/email_cell.dart';
import 'package:app_in_mail/screens/login/login_screen.dart';
import 'package:app_in_mail/utils/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:app_in_mail/screens/home/email_details.dart';
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
  var selectedEmails = List<Email>();
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
        EmailCell(
          isSelected: this.selectedEmails.contains(email),
          email: email,
          onPictureTap: () => _toggleSelection(email),
        ),
        Divider(),
      ]),
    );
  }

  void _toggleSelection(Email email) {
    var isSelected = this.selectedEmails.contains(email);
    setState(() {
      if (isSelected) {
        this.selectedEmails.remove(email);
      } else {
        this.selectedEmails.add(email);
      }
    });
  }

  void _navigateToEmail(Email email) async{
    var emailUrl = await RestApiClient.buildEmailMobileViewerPageURL(
       _mailBoxes.first, email.id);
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return EmailDetails(emailUrl: emailUrl);
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
