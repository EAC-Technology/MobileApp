import 'package:app_in_mail/model/ant_market_data.dart';
import 'package:app_in_mail/model/email_user.dart';
import 'package:app_in_mail/model/ewallet_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:app_in_mail/model/email.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';

class RestApiClient {
  static final adminBaseUrl = 'https://admin.appinmail.io';
  static String dedicatedInstanceBaseUrl;
  static final appId = '7f459762-e1ba-42d3-a0e1-e74beda2eb85';
  static final objId = '5073ff75-da99-44fb-a5d7-e44e5ab28598';
  static EmailUser signedInEmailUser;
  static EwalletUser signedInEwalletUser;
  static String _userName;
  static String _password;

  ///Awakes an user dedicated server instance and stores its base url for any further requests.
  ///User dedicated instances have short live span and we need to awake one once we need or we stop receiving responses.
  ///parameters - user email and password in plain text.
  static Future<String> awakeServerRuntime(
      String email, String password) async {
    //Note to Nicolas : You may reconsider sending username and password in the url query as this is not quite a good practice.

    final passwordMD5Hash = generateMd5(password);
    final path = '/api/v1/experimental/promail/prepare_user_runtime';
    final dataURL = adminBaseUrl +
        path +
        '?user_id=' +
        email +
        "&password_md5=" +
        passwordMD5Hash;

    var result = await getResponse(dataURL);
    dedicatedInstanceBaseUrl = result;
    _userName = email;
    _password = password;
    return result;
  }

  static Future<bool> testAntAPI(String email, String password) async {

    var eWalletUser = await signIntoEwallet(email, password);

    String accessToken = eWalletUser.accessToken;
    //this one is verified and working
    var antPricePreauthURL =
        'https://walletdev.appinmail.io/api/v2/antprice?token=' +
            accessToken +
            '&amount=10';
    //this one is verified and working
    var eurPricePreauthURL =
        'https://walletdev.appinmail.io/api/v2/eurprice?token=' +
            accessToken +
            '&amount=10';

    var chartDataUrl =
        'https://walletdev.appinmail.io/api/v2/exchanger_data?range=24HOURS';
    var result = await getResponse(chartDataUrl);
    var resultList = json.decode(result) as List;
    AntMarketDataModel chartDataModel = AntMarketDataModel.fromJson(resultList);

    print(result);
    //final user = User.fromJson(result);
    //Wallet operations ===============================================>

    // var preauthURL = 'https://walletdev.appinmail.io/api/v2/preauth';

    // final preauthDataURL = preauthURL +
    //     path +
    //     "?" +
    //     'appid=' +
    //     appId +
    //     "&objid=" +
    //     objId +
    //     '&action_name=' +
    //     action +
    //     '&xml_data=' +
    //     urlEncodedXmlData +
    //     '&sid=' +
    //     sid;

    return true;
  }

  static Future<EmailUser> signIntoEmail(String email, String password) async {
    if (dedicatedInstanceBaseUrl == null) {
      return null;
    }
    final path = '/restapi.py';
    final action = 'login';
    final rawXmlData = '{ "login": "' +
        email +
        '","password": "' +
        password +
        '"}'; // PP: No, I have no idea why we call that xml data , but I kept it to be consistent with the server. :(
    final urlEncodedXmlData = Uri.encodeFull(rawXmlData);
    final dataURL = dedicatedInstanceBaseUrl +
        path +
        "?" +
        'appid=' +
        appId +
        "&objid=" +
        objId +
        '&action_name=' +
        action +
        '&xml_data=' +
        urlEncodedXmlData;

    var result = await getResponse(dataURL);
    final user = EmailUser.fromJson(result);
    signedInEmailUser = user;
    return user;
  }

  static Future<EwalletUser> signIntoEwallet(
      String email, String password) async {
    final md5Password = generateMd5(password);
    final antLoginBaseUrl = 'https://admin.appinmail.io';
    final antObjId = '9d29fd1a-ae9b-4b92-8c2f-72c15d18dcf6';
    final path = '/restapi.py';
    final action = 'remote_login';
    final rawXmlData = '{' +
        '"user_email":"' +
        email +
        '","user_login":"' +
        email +
        '","password":"' +
        password +
        '","password_md5":"' +
        md5Password +
        '"}';
    final urlEncodedXmlData = Uri.encodeFull(rawXmlData);
    final dataURL = antLoginBaseUrl +
        path +
        "?"
        "objid=" +
        antObjId +
        '&action_name=' +
        action +
        '&xml_data=' +
        urlEncodedXmlData;

    var result = await getResponse(dataURL);

    final user = EwalletUser.fromJson(result);
    signedInEwalletUser = user;
    return user;
  }

  static Future<List<Email>> getEmailsList(String mailbox) async {
    await _awakeInstanceIfNeeded();
    final sid = signedInEmailUser.sessionId;
    final path = '/restapi.py';
    final action = 'eac_list';
    final rawXmlData = '{ "mailbox": "' +
        mailbox +
        '"}'; // PP: No, I have no idea why we call that xml data , but I kept it to be consistent with the server. :(
    final urlEncodedXmlData = Uri.encodeFull(rawXmlData);

    final dataURL = dedicatedInstanceBaseUrl +
        path +
        "?" +
        'appid=' +
        appId +
        "&objid=" +
        objId +
        '&action_name=' +
        action +
        '&xml_data=' +
        urlEncodedXmlData +
        '&sid=' +
        sid;

    var result = await getResponse(dataURL);

    var emails = List<Email>();
    for (final emailJson in result) {
      emails.add(Email.fromJson(emailJson));
    }

    return emails;
  }

  static Future<String> buildEmailMobileViewerPageURL(
      String mailbox, int mailId) async {
    await _awakeInstanceIfNeeded();
    final sid = signedInEmailUser.sessionId;
    final url = dedicatedInstanceBaseUrl +
        '/eacviewer_mobile?id=' +
        mailId.toString() +
        '&mailbox=' +
        mailbox +
        '&sid=' +
        sid;

    return url;
  }

  static Future<Null> _awakeInstanceIfNeeded() async {
    // if (dedicatedInstanceBaseUrl != null) {
    //   final path = '/restapi.py';
    //   final dataURL = dedicatedInstanceBaseUrl +
    //     path +
    //     "?" +
    //     'appid=' +
    //     appId +
    //     "&objid=" +
    //     objId +
    //     '&sid=' +
    //     signedInUser.sessionId;

    // var result = await getResponse(dataURL);
    // print(result);

    // }else {
    await awakeServerRuntime(_userName, _password); //TODO: find a better way.
    //}
  }

  static Future<List<String>> getMailboxesList() async {
    final sid = signedInEmailUser.sessionId;
    final path = '/restapi.py';
    final action = 'list_mailboxes';

    final dataURL = dedicatedInstanceBaseUrl +
        path +
        "?" +
        'appid=' +
        appId +
        "&objid=" +
        objId +
        '&action_name=' +
        action +
        '&sid=' +
        sid;

    var result = await getResponse(dataURL);

    return List<String>.from(result);
  }

  static Future getResponse(String dataURL) async {
    http.Response response = await http.get(dataURL).catchError((error) {
      print(error);
    });

    if (response == null) {
      throw (Localization.getString(Strings.noInternet));
    }

    if (response.statusCode != 200) {
      throw ('Server responded with status code: ' +
          response.statusCode.toString());
    }
    var responseArray = json.decode(response.body) as List;
    final result = responseArray[1];
    //print(response.body);
    if (responseArray[0] == 'error') {
      dedicatedInstanceBaseUrl = null;
      if (result.toString().toLowerCase().contains("auth error")) {
        //we need that check because the server returns status 200 on auth error.
        throw (Localization.getString(Strings.invalidCredentials));
      } else {
        throw result.toString();
      }
    }
    return result;
  }

  static bool needsLogin() {
    return signedInEmailUser == null;
  }

  static logOut() {
    signedInEmailUser = null;
  }

  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
