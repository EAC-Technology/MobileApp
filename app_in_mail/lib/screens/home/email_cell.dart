import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/model/email.dart';
import 'package:app_in_mail/model/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmailCell extends ListTile {
  EmailCell({Key key, this.email, this.onPictureTap, this.isSelected = false})
      : super(key: key);
  final Function onPictureTap;
  final Email email;
  final bool isSelected;

  Widget _buildLabelsList() {
    return Container(
      height: 30.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(5.0),
          itemBuilder: (context, index) {
            if (index < email.labels.length) {
              return Row(
                children: <Widget>[
                  _buildLabelCell(index),
                  Container(
                    width: 5,
                  ) //space between items
                ],
              );
            }
          }),
    );
  }

  Widget _buildLabelCell(int index) {
    final Label label = email.labels[index];
    return Container(
      padding: const EdgeInsets.all(3.0),
      child: Text(
        label.name,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: label.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 10.0),
      ),
      decoration: new BoxDecoration(
          color: label.color,
          borderRadius: new BorderRadius.all(Radius.circular(3))),
      height: 20.0,
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 40.0), //spacing
        ClipRRect(
            borderRadius: BorderRadius.all(const Radius.circular(7.0)),
            child: GestureDetector(
              onTap: this.onPictureTap,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/avatar.png',
                    width: 43.0,
                    height: 43.0,
                  ),
                  this.isSelected
                      ? Container(
                          color: AppColors.darkBackground.withAlpha(200),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30,
                          ),
                          width: 43,
                          height: 43,
                        )
                      : Container()
                ],
              ),
            )),
        Container(width: 10.0), //horizontal spacer.
        Expanded(
            child: Container(
          height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          email.isNew
                              ? SvgPicture.asset(Img.icDot,
                                  width: 8.0, height: 8.0)
                              : Container(),
                          email.isNew ? Container(width: 10.0) : Container(),
                          Text(
                            email.fromName,
                            style: TextStyle(
                                fontWeight: email.isNew
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 16.0,
                                color: AppColors.titleTextColor),
                          ),
                        ],
                      ),
                      Text(
                        email.subject,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: email.isNew
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14.0,
                            color: AppColors.emailSeenTextColor),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          email.formattedTimeStamp(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: email.isNew
                                  ? AppColors.accentColor
                                  : AppColors.emailSeenDateColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              //Preview
              Text(
                email.preview,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12.0,
                    color: AppColors.emailSeenTextColor),
              ),

              _buildLabelsList(),
            ],
          ),
        ))
      ],
    );
  }
}

class LabelClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    final arrowStartX = size.width - 15.0;
    path.moveTo(0.0, 0.0);
    path.lineTo(arrowStartX, 0.0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(arrowStartX, size.height);
    path.lineTo(0.0, size.height);
    path.moveTo(0.0, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
