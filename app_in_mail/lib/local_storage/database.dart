import 'dart:async';
import 'dart:io' as io;
import 'package:app_in_mail/model/email.dart';
import 'package:app_in_mail/model/label.dart';
import 'package:app_in_mail/utils/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "app_in_mail.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Emails(id INTEGER PRIMARY KEY, subject TEXT,priority INTEGER, renderedvdomxml TEXT,fromname TEXT, preview Text, timestamp INTEGER, fromemail Text, isnew BOOLEAN)");
    await db.execute(
        "CREATE TABLE Labels(emailid INTEGER, text TEXT, colorhex Text, textcolorhex)");
    await db.execute(
        "CREATE TABLE Recipients(emailid INTEGER, name TEXT)");
    
    await db.execute(
        "CREATE INDEX email_ids ON Emails (id)");
    await db.execute(
        "CREATE INDEX label_emailids ON Labels (emailid)");
    await db.execute(
        "CREATE INDEX recipient_emailids ON Recipients (emailid)");
  }

  Future<List<Email>> getEmails() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Employee');
    List<Email> emails = new List();
    for (int i = 0; i < list.length; i++) {
      var record = list[i];
      emails.add(new Email(
          fromEmail: record['fromemail'],
          fromName: record['fromame'],
          id: record['id'],
          labels: record['labels'],
          preview: record['preview'],
          priority: record['priority'],
          recipients: record['recipients'],
          renderedVdomxml: record['renderedvdomxml'],
          subject: record['subject'],
          timeStamp: record['timestamp']));
    }

    print(emails.length);
    return emails;
  }

  void saveEmail(Email email) async {
    var dbClient = await db;
    await dbClient.transaction((transaction) async {
      //Doing UPSERT according to https://www.sqlite.org/lang_UPSERT.html
      await transaction.execute(
          "INSERT INTO 'Emails' ('id','subject','priority','renderedvdomxml','fromname', 'preview', 'timestamp', 'fromemail' , 'isnew') " +
              " VALUES(?,?,?,?,?,?,?,?,?)" +
              " ON CONFLICT(id) DO" +
              " UPDATE SET subject=excluded.subject, priority = excluded.priority, renderedvdomxml = excluded.renderedvdomxml, fromname = excluded.fromname, preview = excluded.preview, timestamp = excluded.timestamp, fromemail = excluded.fromemail, isnew = excluded.isnew",
          [
            email.id,
            email.subject,
            email.priority,
            email.renderedVdomxml,
            email.fromName,
            email.preview,
            email.timeStamp,
            email.fromEmail,
            email.isNew
          ]);

      //Delete labels
      await transaction
          .execute("DELETE FROM 'Labels' WHERE emailid = ?", [email.id]);
      //Insert up-to-date labels
      for (Label label in email.labels) {
        await transaction.execute(
            "INSERT INTO 'Labels' (emailid, text, colorhex, textcolorhex)" +
                " VALUES(?,?,?,?)",
            [
              email.id,
              label.name,
              label.colorHex,
              label.textColorHex,
            ]);
      }

      //Delete recepients 
      await transaction
          .execute("DELETE FROM 'Recipients' WHERE emailid = ?", [email.id]);

      //Insert up-to-date recipients
      for (String recipient in email.recipients) {
        await transaction.execute(
            "INSERT INTO 'Recipients' (emailid, name)" +
                " VALUES(?,?)",
            [
              email.id,
              recipient
            ]);
      }
    }).catchError((error) {
      Log.e(error.toString());
    });
  }
}

//todo: need to add indices.
//todo save recipients/
