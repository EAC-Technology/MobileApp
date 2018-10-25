import 'package:app_in_mail/constants/colors.dart';
import 'package:flutter/material.dart';

enum InfoPageTypes {
  contactAndSupport, faq, privacyPolicyAndCookies, sofrwareLicense, terms
}

class GeneralInfoScreen extends StatefulWidget {
  final InfoPageTypes pageType;
  final String title;
  
  GeneralInfoScreen({this.pageType, this.title});

  @override
  _GeneralInfoScreenState createState() => _GeneralInfoScreenState();
}

class _GeneralInfoScreenState extends State<GeneralInfoScreen> {
  
  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      title: new Text(
        widget.title,
        style: TextStyle(
            color: AppColors.titleTextColor,
            fontSize: 22.0,
            fontWeight: FontWeight.bold),
      ),
      elevation: 0.5,
      leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: AppColors.titleTextColor,
            size: 32.0,
          ),
          onPressed: () => Navigator.of(context).pop()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Text(_getContent(), style: TextStyle( color: AppColors.greyLight),),
    );

  }

  //TODO: get actual content here - either from resources or a web link.
  String _getContent() {
    String sampleString;
    switch (widget.pageType) {
      
      case InfoPageTypes.contactAndSupport:
        sampleString = "Contact and support...";
        break;
        case InfoPageTypes.faq:
        sampleString = "Faq ...";
        break;
          case InfoPageTypes.privacyPolicyAndCookies:
        sampleString = "Privacy ....";
        break;
          case InfoPageTypes.sofrwareLicense:
        sampleString = "License ...";
        break;
          case InfoPageTypes.terms:
        sampleString = "Terms ....";
        break;
    }
    
    return sampleString + 'Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.Lorem ipsum dolor sin amet.';
  }

}