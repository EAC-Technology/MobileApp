import 'package:intl/intl.dart';
import 'label.dart';
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
    //final localeName = Platform.localeName;
    var emailDate = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    var formatter = new DateFormat.yMEd();
    String formatted = formatter.format(emailDate);
    
    return formatted;
  }
}
