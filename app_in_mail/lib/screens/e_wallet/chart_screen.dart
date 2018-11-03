import 'package:app_in_mail/constants/colors.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartScreen extends StatefulWidget {
  final List<charts.Series> seriesList;

  ChartScreen(this.seriesList);

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

  ///TODO:  Remove mocked data , when  we implement the bloc for the real data.
  factory ChartScreen.withSampleData() {
    return new ChartScreen(
      _createSampleData(),
    );
  }

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  double slliderValue = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
        ),
        _buildChart(),
        Padding(
          padding: const EdgeInsets.only(left: 1, right: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Center(child: Text('12 Hours')),
                  height: 40,
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(child: Text('24 Hours')),
                  height: 40,
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(child: Text('7 days')),
                  height: 40,
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(child: Text('1M')),
                  height: 40,
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(child: Text('6M')),
                  height: 40,
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(child: Text('Year')),
                  height: 40,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: SliderTheme(
            child: Slider(
              divisions: 5,
              onChanged: (double value) {
                setState(() {
                  slliderValue = value;
                });
              },
              value: slliderValue,
            ),
            data: Theme.of(context).sliderTheme.copyWith(
                  thumbShape: _CustomThumbShape(),
                  inactiveTrackColor: AppColors.accentColor,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildChart() {
    return Container(
      height: 300,
      child: charts.TimeSeriesChart(
        widget.seriesList,
        animate: true,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }
}

/// Sample time series data type.
class TimeSeriesValues {
  final DateTime time;
  final int values;

  TimeSeriesValues(this.time, this.values);
}

class _CustomThumbShape extends SliderComponentShape {
  static const double _thumbSize = 4.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromRadius(_thumbSize)
        : const Size.fromRadius(_disabledThumbSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset thumbCenter, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;
    final thumbSide = 35;
    final borderRadius = 8.0;

    final RRect borderRect = RRect.fromLTRBAndCorners(
      thumbCenter.dx - thumbSide / 2,
      thumbCenter.dy - thumbSide / 2,
      thumbCenter.dx + thumbSide / 2,
      thumbCenter.dy + thumbSide / 2,
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
    );

    Path shadowPath = Path();
    shadowPath.addRRect(borderRect);
    canvas.drawShadow(shadowPath, Colors.grey[100], 10, false);

    Paint backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRRect(borderRect, backgroundPaint);

    Paint foregroundPaint = Paint()
      ..color = AppColors.accentColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(thumbCenter, 8, foregroundPaint);
  }
}
