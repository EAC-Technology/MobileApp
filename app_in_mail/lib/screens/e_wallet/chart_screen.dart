import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/model/ant_market_data.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/screens/e_wallet/labeled_value_box.dart';
import 'package:app_in_mail/screens/e_wallet/percentage_indicator.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final sliderDiscreteValues = [
    Localization.getString(Strings.twelveHours),
    Localization.getString(Strings.twentyFourHours),
    Localization.getString(Strings.sevenDays),
    Localization.getString(Strings.oneMonth),
    Localization.getString(Strings.sixMonths),
    Localization.getString(Strings.oneYear),
  ];

  AntMarketDataModel dataModel = AntMarketDataModel();

  void _loadData() async {
    var dataModel = await RestApiClient.getMarketData();
    setState(() {
          this.dataModel = dataModel;
        });
  }

   List<charts.Series<AntValueInTime, DateTime>> _getChartSeries() {
    return [
      new charts.Series<AntValueInTime, DateTime>(
        id: 'Values',
        colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
        domainFn: (AntValueInTime rate, _) => rate.date,
        measureFn: (AntValueInTime rate, _) => rate.value,
        data: dataModel.chartData.items,
      )
    ];
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  int sliderValue = 1;

  Widget _buildSliderDiscreteValueLabel(int index) {
    Color textColor =
        index == sliderValue ? AppColors.accentColor : AppColors.titleTextColor;
    return Expanded(
      child: Container(
        child: Center(
            child: Text(
          sliderDiscreteValues[index],
          style: TextStyle(color: textColor),
        )),
        height: 40,
      ),
    );
  }

  Widget _buildSliderLabels() {
    List<Widget> labels = [];

    for (var i = 0; i < sliderDiscreteValues.length; i++) {
      labels.add(_buildSliderDiscreteValueLabel(i));
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: labels,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              Img.icAnt,
              height: 30,
              color: AppColors.titleTextColor,
            ),
            Text(
              '/',
              style: TextStyle(color: AppColors.titleTextColor, fontSize: 30),
            ),
            SvgPicture.asset(
              Img.icEuro,
              height: 30,
              color: AppColors.titleTextColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                dataModel.resultingAntPrice.toString(),
                style: TextStyle(
                    color: AppColors.titleTextColor,
                    fontSize: 38,
                    fontWeight: FontWeight.bold),
              ),
            ),
            PercentageIndicator(
              percentValue: dataModel.percent,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildHeader(),
          _buildChart(),
          _buildSliderLabels(),
          _buildSlider(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              LabeledValueBox(
                title: Localization.getString(Strings.antMktCapp),
                value: '€ ' + this.dataModel.antMarketCap.toString(),
              ),
              LabeledValueBox(
                title: Localization.getString(Strings.eurReserve),
                value: 'No data in API!'// The api response at https://walletdev.appinmail.io/api/v2/exchanger_data?range=7DAYS ahs AgtSupply, but not Eur reserve.
              ),
            ],
          ),
          Row(
            children: <Widget>[
              LabeledValueBox(
                title: Localization.getString(Strings.antSupply),
                value: '€ ' + this.dataModel.antSupply.toString(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Padding _buildSlider() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: SliderTheme(
        child: Slider(
          min: 0,
          max: 5,
          divisions: 5,
          onChanged: (double value) {
            setState(() {
              sliderValue = value.toInt();
            });
          },
          value: sliderValue.toDouble(),
        ),
        data: Theme.of(context).sliderTheme.copyWith(
              thumbShape: _CustomThumbShape(),
              inactiveTrackColor: AppColors.accentColor,
            ),
      ),
    );
  }

  Widget _buildChart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 360,
        child: charts.TimeSeriesChart(
          _getChartSeries(),
          animate: true,
          dateTimeFactory: const charts.LocalDateTimeFactory(),
        ),
      ),
    );
  }
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
