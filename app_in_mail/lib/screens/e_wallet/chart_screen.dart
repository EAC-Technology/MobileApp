/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  final List<charts.Series> seriesList;

  ChartScreen(this.seriesList);

  ///TODO:  Remove mocked data , when  we implement the bloc for the real data.
  factory ChartScreen.withSampleData() {
    return new ChartScreen(
      _createSampleData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 60,), 
        _buildChart(),
      ],
    );
  }

  Widget _buildChart() {
    return Container(
      height: 300,
      child: charts.TimeSeriesChart(
        seriesList,
        animate: true,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }

  /// Todo: bellow is a sample hardcoded data , until we provide the real data with bloc.
  static List<charts.Series<TimeSeriesValues, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesValues(new DateTime(2017, 9, 19), 5),
      new TimeSeriesValues(new DateTime(2017, 9, 26), 25),
      new TimeSeriesValues(new DateTime(2017, 10, 3), 100),
      new TimeSeriesValues(new DateTime(2017, 10, 10), 75),
    ];

    return [
      new charts.Series<TimeSeriesValues, DateTime>(
        id: 'Values',
        colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
        domainFn: (TimeSeriesValues sales, _) => sales.time,
        measureFn: (TimeSeriesValues sales, _) => sales.values,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesValues {
  final DateTime time;
  final int values;

  TimeSeriesValues(this.time, this.values);
}
