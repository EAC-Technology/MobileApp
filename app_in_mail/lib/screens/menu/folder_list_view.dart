import 'package:app_in_mail/blocs/emails_bloc.dart';
import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/model/label.dart';
import 'package:app_in_mail/model/mailbox.dart';
import 'package:app_in_mail/screens/home/homePage.dart';
import 'package:app_in_mail/screens/menu/folder_item_view.dart';
import 'package:app_in_mail/screens/menu/menu_filter_item.dart';
import 'package:app_in_mail/screens/menu/menu_item_view.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';

class FolderListView extends StatefulWidget {
  @override
  _FolderListViewState createState() => _FolderListViewState();
}

class _FolderListViewState extends State<FolderListView> {
  var isInEditMode = false;
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
    return new CustomScrollView(slivers: [
      new SliverToBoxAdapter(
          child: this.isInEditMode
              ? Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.clear,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            this.isInEditMode = false;
                          });
                        },
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                  child: Text(
                    "accountholder@sampleemail.com",
                    style: TextStyle(color: AppColors.greyLight),
                  ),
                )),
      new SliverList(
        delegate: new SliverChildListDelegate(
          new List<Widget>.generate(5, (int index) {
            return FolderItemView(
              isInEditMode: this.isInEditMode,
              mailbox: fakeData[index],
              onTap: () => this._navigateToHome(context),
            );
          }),
        ),
      ),
      _buildFooter(),
      _buildFilteringList(),
    ]);
  }

  Widget _buildFilteringList() {
    var testLabels = [
      Label(colorHex: '67D0F1', name: 'EAC', textColorHex: 'FFFFFF'),
      Label(colorHex: 'EF3671', name: 'Urgent', textColorHex: 'FFFFFF'),
      Label(colorHex: 'AA4455', name: 'Social', textColorHex: 'FFFFFF')
    ];
    return SliverList(
      delegate: new SliverChildListDelegate(
        new List<Widget>.generate(3, (int index) {
          return MenuFilterItem(
            label: testLabels[index],
            onTap: () {},
          );
        }),
      ),
    );
  }

  SliverToBoxAdapter _buildFooter() {
    if (this.isInEditMode) {
      return SliverToBoxAdapter(
        child: MenuItemView(
          onTap: null,
          textColor: AppColors.accentColor,
          title: Localization.getString(Strings.add),
          icon: Icon(
            Icons.add,
            color: AppColors.accentColor,
            size: 30,
          ),
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () {
                  setState(() {
                    this.isInEditMode = true;
                  });
                }),
          ),
        ),
      );
    }
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
