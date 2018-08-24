import 'package:flutter/material.dart';
import '../restApi/email.dart';
import '../restApi/label.dart';


class EmailCell extends ListTile {
  EmailCell({Key key, this.email}) : super(key: key);

  final Email email;
  
  Widget _buildLabelsList() {
    return Container(height: 30.0,
     child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(5.0),
        itemBuilder: (context, index) {
          if (index < email.labels.length) {
            return _buildLabelCell(index);
          }
        }),
    );

  }

  Widget _buildLabelCell(int index) {
    final Label label = email.labels[index];
    return Row( children: <Widget>[
      ClipPath(child: Container(
      padding: const EdgeInsets.all(3.0),
      child: Text(label.name, style: TextStyle( color: label.textColor,
                            fontWeight: FontWeight.bold, fontSize: 10.0),),
      color: label.color, width: 48.0, height: 20.0 ), clipper: LabelClipper(),),
      Container(width: 8.0,) //Spacer.
    ]);
  }

  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 40.0), //spacing
        ClipRRect(
            borderRadius: BorderRadius.all(const Radius.circular(20.0)),
            child: Image.asset(
              'assets/avatar.png',
              width: 100.0,
            )),
        Container(width: 10.0), //horizontal spacer.
        Expanded(
            child: Container(
          height: 150.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Subject
              Text(
                email.subject,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              //Preview
              Text(email.preview, maxLines: 3, overflow: TextOverflow.ellipsis),
              Container(height: 10.0), //Spacer
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        email.fromName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.0),
                      ),
                      Text(
                        email.fromEmail,
                        style: TextStyle(
                            fontWeight: FontWeight.w100, fontSize: 10.0),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        //TimeStamp
                        Text(email.formattedTimeStamp(),
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 14.0)),
                      ],
                    ),
                  )
                ],
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
