import 'package:flutter/material.dart';
import 'package:app_in_mail/localization.dart';

class LocaleSelector extends StatefulWidget {
  LocaleSelector({Key key, this.title}) : super(key: key);

  final String title;
  @override
  LocaleSelectorState createState() => new LocaleSelectorState();
}

class LocaleSelectorState extends State<LocaleSelector> {
  List<String> _locales = Localization.supportedLocales;
  @override
  void initState() {
    super.initState();
  }


  Widget _buildListCell(int index) {
    //return Text('asdfasdf');
    return GestureDetector(
      onTap: () {
        _switchLocale(index);
      },
      child: Row(children: <Widget>[Text(_locales[index].toUpperCase(),
      
      style: TextStyle(decoration: TextDecoration.underline, fontSize: 18.0, color: getTextColor(index)),
      ),
      Container(width: 15.0,)
      ],
      )
        
    );
  }

  Color getTextColor(index) {
    if(Localization.languageCode == _locales[index]) {
      return Color.fromRGBO(218, 34, 80, 1.0);
    }
    
    return Colors.grey;
  }

  void _switchLocale(int index) {
      final localeCode = _locales[index];
      Localization.setLocale(localeCode); 
  }

  Widget _buildLocalesList() {
    return Center(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(5.0),
          itemBuilder: (context, index) {
            if (index < _locales.length) {
              return _buildListCell(index);
            }
          }),
    );
  }

  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 100.0,
          height: 30.0,
          child: _buildLocalesList()),
    );
  }
}
