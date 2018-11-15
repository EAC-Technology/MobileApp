// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_in_mail/main.dart';
//import 'package:http/http.dart' as http;

void main() {

  // test('my first unit test', () async{
  //   String dataURL = "https://admin.appinmail.io/api/v1/experimental/promail/prepare_user_runtime?user_id=p.pavlov@appinmail.io&password_md5=81dc9bdb52d04dc20036dbd8313ed055"; 
  //   http.Response response = await http.get(dataURL);
    
  //   print(response.body);
  //   expect(42, 42);
  // });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
