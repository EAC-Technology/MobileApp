import 'package:convert/convert.dart';

// class AntValueInTime{
//   double value;
//   DateTime date;

//   AntValueInTime({this.date, this.value};

//   factory EmailAntValueInTime.fromJson(Map<dynamic, dynamic> json) {
//     final map = json;
//     return AntValueInTime(
//         value: map['email'],
//         guid: map['guid'],
//         firstName: map['first_name'],
//         lastName: map['last_name'],
//         sessionId: map['sid']);
//   }
// }

class AntMarketDataModel {
  final String rangeTitle;
  final double percent;
  final double resultingAntPrice;
  final double agtSupply;
  final double antMarketCap;
  final double antSupply;

  final DateTime minDate;
  final DateTime maxDate;


  AntMarketDataModel(
      {this.rangeTitle,
      this.percent,
      this.resultingAntPrice,
      this.agtSupply,
      this.antMarketCap,
      this.antSupply,
      this.minDate,
      this.maxDate
      });

  factory AntMarketDataModel.fromJson(List<dynamic> json) {
    Map valuesOverTime = json[0];
    Map datesRange = json[1];
    Map map = json[2];

    
    return AntMarketDataModel(
        rangeTitle: map['range_title'],
        percent: double.parse(map['percent']),
        resultingAntPrice: double.parse(map['ResultingAntPrice']),
        agtSupply: double.parse(map['AgtSupply']),
        antMarketCap: double.parse(map['AntMarketCap']),
        antSupply: double.parse(map['AntSupply']),
        minDate: DateTime.fromMillisecondsSinceEpoch(((datesRange['min'] as double) * 1000).round()),
        maxDate: DateTime.fromMillisecondsSinceEpoch(((datesRange['max'] as double) * 1000).round()),

        );
  }
}
