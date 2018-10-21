import 'package:app_in_mail/model/email.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

///This is inherited widget that provides access to the AppInMail bloc.
class AppInMailBlocProvider extends InheritedWidget {
  final AppInMailBloc appInMailBloc;

  AppInMailBlocProvider({
    Key key,
    AppInMailBloc appInMailBloc,
    Widget child,
  })  : appInMailBloc = appInMailBloc ?? AppInMailBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppInMailBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AppInMailBlocProvider) as AppInMailBlocProvider)
          .appInMailBloc;
}

class EmailsDownload {
  final String mailBox; 
  EmailsDownload({this.mailBox});
}

class EmailsSearch {
  final String searchText;
  EmailsSearch({this.searchText});
}

class AppInMailBloc {
  static List<Email> _downloadedEmails = List<Email>(); // Todo: refactor: instead of static field , we may use a repository here.
  static List<Email> _filteredEmails = List<Email>(); // Todo: refactor: instead of static field , we may use a repository here.
  final _emailsList = BehaviorSubject<List<Email>>(seedValue: _downloadedEmails);
  final _emailsDownloadController = StreamController<EmailsDownload>();
  final _emailsSearchController = StreamController<EmailsSearch>();

  AppInMailBloc() {
    _emailsDownloadController.stream.listen(_handleEmailsDownloadRequest);
    _emailsSearchController.stream.listen(_handleSearchRequest);
  }

  Sink<EmailsDownload> get emailsDownload => _emailsDownloadController.sink;
  Sink<EmailsSearch> get emailsEmailsSearch => _emailsSearchController.sink;

  ValueObservable<List<Email>> get emails => _emailsList.stream;

  /// Take care of closing streams.
  void dispose() {
    _emailsList.close();
    _emailsDownloadController.close();
    _emailsSearchController.close();
  }

  void _handleSearchRequest(EmailsSearch searchRequest) {
    var lowerCased = searchRequest.searchText.toLowerCase();
    _filteredEmails = _downloadedEmails.where((email) {
      return lowerCased.isEmpty ||
       email.fromName.toLowerCase().contains(lowerCased) ||
       email.fromEmail.toLowerCase().contains(lowerCased) ||
       email.preview.toLowerCase().contains(lowerCased) ||
       email.subject.toLowerCase().contains(lowerCased) ||
       email.renderedVdomxml.toLowerCase().contains(lowerCased);
       

    }).toList();

    _emailsList.add(_filteredEmails);
  }
  
  void _handleEmailsDownloadRequest(EmailsDownload download) async{
    _downloadedEmails = await RestApiClient.getEmailsList(download.mailBox);  //.catchError(_onError);  Todo handle errors in bloc .
    _emailsList.add(_downloadedEmails);
  }
}
