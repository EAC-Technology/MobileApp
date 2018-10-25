import 'package:app_in_mail/blocs/emails_bloc.dart';
import 'package:app_in_mail/model/mailbox.dart';
import 'package:app_in_mail/screens/home/homePage.dart';
import 'package:app_in_mail/screens/menu/folder_item_view.dart';
import 'package:flutter/material.dart';

class FolderListView extends StatefulWidget {
  @override
  _FolderListViewState createState() => _FolderListViewState();
}

class _FolderListViewState extends State<FolderListView> {
  
  //TODO: replace the fake data with real mailboxes comming from the server.
  final List<Mailbox> fakeData = [
    Mailbox(hasNewItems: true, itemCount: 754, title: 'Inbox'),
    Mailbox(hasNewItems: false, itemCount: 54, title: 'Outbox'),
    Mailbox(hasNewItems: false, itemCount: 0, title: 'Draft'),
    Mailbox(hasNewItems: false, itemCount: 0, title: 'Trash'),
    Mailbox(hasNewItems: false, itemCount: 2, title: 'Archive'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: 5,
        itemBuilder: (context, index) {
          return FolderItemView( mailbox: fakeData[index], onTap: ()=> this._navigateToHome(context),);
        });
  }

  _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return AppInMailBlocProvider(child: new HomePage());
        },
      ),
    );
  }
}
