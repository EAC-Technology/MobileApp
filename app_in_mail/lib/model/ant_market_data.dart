import 'package:convert/convert.dart';

class AntValueInTime{
  double value;
  DateTime date;
  AntValueInTime({this.date, this.value});
}



class AntMarketDataModel {
  final String rangeTitle;
  final double percent;
  final double resultingAntPrice;
  final double agtSupply;
  final double antMarketCap;
  final double antSupply;

  final DateTime minDate;
  final DateTime maxDate;

  final ChartData chartData;

  AntMarketDataModel(
      {this.chartData,
      this.rangeTitle,
      this.percent,
      this.resultingAntPrice,
      this.agtSupply,
      this.antMarketCap,
      this.antSupply,
      this.minDate,
      this.maxDate,
      });

  factory AntMarketDataModel.fromJson(List<dynamic> json) {
    Map chartDataJson = json[0];
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
        chartData: ChartData.fromJson(chartDataJson),
        );
  }
}

class ChartData {
  final List<AntValueInTime> items;

  ChartData({this.items});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    var items = List<AntValueInTime>();

    for(String key in json.keys) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch((double.parse(key) * 1000).round());
      double value = double.parse(json[key]);
      items.add(AntValueInTime(date: date, value: value));
    }

    items.sort((left, right) => left.date.compareTo(right.date));

    return ChartData(items: items);
  }
}
