import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as c;

class BarData {
  final String x;
  final double y;
  final Color color;
  const BarData({required this.x, required this.y, required this.color});
}

class WinRateBarChart extends StatelessWidget {
  /// List of [BarData] to paint over a [c.BarChart]. See [BarData].
  final List<BarData> dataSource;
  WinRateBarChart({required this.dataSource});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width - 48,
      child: c.BarChart(
        [c.Series<BarData, String>(
          id: "Win Rates",
          domainFn: (BarData data, _) => data.x,
          colorFn: (BarData data, _) => c.ColorUtil.fromDartColor(data.color),
          measureFn: (BarData data, _) => (data.y == -1 ? 0 : data.y)*100,
          data: dataSource
        )],
        primaryMeasureAxis: c.NumericAxisSpec(
          tickProviderSpec: c.BasicNumericTickProviderSpec(
            dataIsInWholeNumbers: false,
            desiredTickCount: 5
          ),
          renderSpec: c.GridlineRendererSpec(
            labelStyle: c.TextStyleSpec(
              color: c.ColorUtil.fromDartColor(
                Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
              )),
            lineStyle: c.LineStyleSpec(color: c.ColorUtil.fromDartColor(
                Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
            )),
          )
        ),
        domainAxis: c.OrdinalAxisSpec(
          renderSpec: c.SmallTickRendererSpec(
              labelStyle: c.TextStyleSpec(
                color: c.ColorUtil.fromDartColor(
                  Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
                )
              ),
              lineStyle: c.LineStyleSpec(color: c.ColorUtil.fromDartColor(
                  Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
              )),
          )
        ),
        animate: true,
        vertical: false,
      )
    );
  }
}
