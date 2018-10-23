import 'package:app_in_mail/utils/email_date_formatter.dart';
import 'package:app_in_mail/model/label.dart';
//import 'dart:io' show Platform;

class Email {
  final int priority;
  final String renderedVdomxml;
  final String fromName;
  final List<String> recipients;
  final String preview;
  final int timeStamp;
  final List<Label> labels;
  final String subject;
  final int id;
  final String fromEmail;
  var isNew = false;

  Email(
      {this.priority,
      this.renderedVdomxml,
      this.fromName,
      this.recipients,
      this.preview,
      this.timeStamp,
      this.labels,
      this.subject,
      this.id,
      this.fromEmail});

  factory Email.fromJson(Map<dynamic, dynamic> json) {
    final map = json;
    return Email(
      priority: int.parse(map['priority']),
      renderedVdomxml: map['rendered_vdomxml'],
      fromName: map['from_name'],
      recipients: List<String>.from(map['recipients']),
      preview: map['preview'],
      timeStamp: map['timestamp'],
      labels: (map['labels'] as List<dynamic>).map((label) => Label.fromJson(label)).toList(),
      subject: map['subject'],
      id: map['id'],
      fromEmail: map['from_email'],
    );
  }
  String formattedTimeStamp() {
    //TODO: parse the date from the email server data and remove the test code bellow:
    
    //Use bellow test dates to validate the date formatter.
    //var emailDate = DateTime.now().subtract(new Duration(hours: 1));
    var emailDate = DateTime.now().subtract(new Duration(days: 2));
    //var emailDate = DateTime.now().subtract(new Duration(days: 8));
    //var emailDate = DateTime.now().subtract(new Duration(days: 330));
    
    
    return EmailDateFormatter.formatDate(emailDate);
  }
}
