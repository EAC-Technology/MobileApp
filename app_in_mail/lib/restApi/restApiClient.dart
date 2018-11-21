import 'package:app_in_mail/constants/api_constants.dart';
import 'package:app_in_mail/model/ant_market_data.dart';
import 'package:app_in_mail/model/email_user.dart';
import 'package:app_in_mail/model/ewallet_user.dart';
import 'package:app_in_mail/model/wallet_ballance.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:app_in_mail/model/email.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';

class RestApiClient {
  static String dedicatedInstanceBaseUrl;

  static EmailUser signedInEmailUser;
  static EwalletUser signedInEwalletUser;
  static String _userName;
  static String _password;

  static Future<String> awakeServerRuntime(
      String email, String password) async {
    final passwordMD5Hash = generateMd5(password);

    final dataURL = ApiConstants.adminBaseUrl +
        ApiConstants.awakeServerRuntimePath +
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

  static Future<AntMarketDataModel> getMarketData(
      String periodParameter) async {
    var chartDataUrl = ApiConstants.walletBaseUrl +
        ApiConstants.marketDataPath +
        '?range=' +
        periodParameter;
    var result = await getResponse(chartDataUrl);
    AntMarketDataModel dataModel =
        AntMarketDataModel.fromJson(json.decode(result) as List);

    return dataModel;
  }

  static Future<String> pollWalletOperationStatus(transactionId ) async {
    String token = signedInEwalletUser.accessToken;
    String statusUrl = ApiConstants.walletBaseUrl + ApiConstants.transactionStatePath  +
        '?transaction_id=' +
        transactionId +
        "&auth_token=" +
        token;
    final status  = await getResponse(statusUrl);

    return status;
  }
  static Future<String> preauthWalletOperation(String transactionType) async {
    String token = signedInEwalletUser.accessToken;
    String t = '{"msg": "' +
        transactionType +
        '","vat": false,"success_url": "","fail_url": "","type": "' +
        transactionType +
        '","to": ""}';
    String info = '{"guid":"' + signedInEmailUser.guid + '"}';

    final preauthUrl = ApiConstants.walletBaseUrl +
        ApiConstants.walletPreauthPath +
        '?token=' +
        token +
        "&t=" +
        Uri.encodeFull(t) +
        "&info=" +
        Uri.encodeFull(info);

    var transactionId = await getResponse(preauthUrl);

    return transactionId;
  }

  static String getOperationTransactionUrl(String transactionId) {
    String token = signedInEwalletUser.accessToken;
    final operationUrl = ApiConstants.walletBaseUrl +
        ApiConstants.operationTransactionPath +
        '?transaction_id=' +
        transactionId +
        "&auth_token=" +
        token;

    return operationUrl;
  }

  static Future<EmailUser> signIntoEmail(String email, String password) async {
    if (dedicatedInstanceBaseUrl == null) {
      return null;
    }

    final action = 'login';
    final rawXmlData = '{ "login": "' +
        email +
        '","password": "' +
        password +
        '"}'; // PP: No, I have no idea why we call that xml data , but I kept it to be consistent with the server. :(
    final urlEncodedXmlData = Uri.encodeFull(rawXmlData);
    final dataURL = dedicatedInstanceBaseUrl +
        ApiConstants.actionApiPath +
        "?" +
        'appid=' +
        ApiConstants.appId +
        "&objid=" +
        ApiConstants.objId +
        '&action_name=' +
        action +
        '&xml_data=' +
        urlEncodedXmlData;

    var result = await getResponse(dataURL);
    final user = EmailUser.fromJson(result);
    signedInEmailUser = user;

    await signIntoEwallet(email, password);
    return user;
  }

  static Future<WalletBallance> getWalletBallance() async {
    var dataURL = ApiConstants.walletBaseUrl +
        ApiConstants.walletBallancePath +
        '?token=' +
        signedInEwalletUser.accessToken +
        '&guid=' +
        signedInEwalletUser.accessToken;
    var result = await getResponse(dataURL);
    return WalletBallance.fromJson(result);
  }

  static Future<String> getAntValueForEuro(String euro) async {
    var dataURL = ApiConstants.walletBaseUrl +
        ApiConstants.antPricePath +
        '?token=' +
        signedInEwalletUser.accessToken +
        '&amount=' +
        euro;
    var result = await getResponse(dataURL);
    return result;
  }

  static Future<String> getEuroValueForAnt(String ant) async {
    var dataURL = ApiConstants.walletBaseUrl +
        ApiConstants.euroPricePath +
        '?token=' +
        signedInEwalletUser.accessToken +
        '&amount=' +
        ant;
    var result = await getResponse(dataURL);

    return result;
  }

  static Future<EwalletUser> signIntoEwallet(
      String email, String password) async {
    final md5Password = generateMd5(password);

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
    final dataURL = ApiConstants.adminBaseUrl +
        ApiConstants.actionApiPath +
        "?"
        "objid=" +
        ApiConstants.antObjId +
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
    final action = 'eac_list';
    final rawXmlData = '{ "mailbox": "' +
        mailbox +
        '"}'; // PP: No, I have no idea why we call that xml data , but I kept it to be consistent with the server. :(
    final urlEncodedXmlData = Uri.encodeFull(rawXmlData);

    final dataURL = dedicatedInstanceBaseUrl +
        ApiConstants.actionApiPath +
        "?" +
        'appid=' +
        ApiConstants.appId +
        "&objid=" +
        ApiConstants.objId +
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

    final action = 'list_mailboxes';

    final dataURL = dedicatedInstanceBaseUrl +
        ApiConstants.actionApiPath +
        "?" +
        'appid=' +
        ApiConstants.appId +
        "&objid=" +
        ApiConstants.objId +
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
