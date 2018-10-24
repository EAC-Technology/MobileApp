import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/model/mailbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FolderItemView extends StatefulWidget {
  final Mailbox mailbox;
  FolderItemView({this.mailbox});

  @override
  _FolderItemViewState createState() => _FolderItemViewState();
}

class _FolderItemViewState extends State<FolderItemView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  Img.icFolder,
                  width: 26.0,
                ),
                Container(
                  width: 15,
                ), //spacing between icon and tittle
                Text(
                  widget.mailbox.title,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Text(
                        widget.mailbox.itemCount.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: new BoxDecoration(
                        color: AppColors.lightDarkBackground,
                        borderRadius:
                            new BorderRadius.all(Radius.circular(13))),
                  ),
                ),
                widget.mailbox.hasNewItems
                    ? SvgPicture.asset(
                        Img.icDot,
                        width: 10.0,
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
