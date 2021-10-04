import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series<TimeSeriesPressures, double>> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate = false});

  factory SimpleTimeSeriesChart.withData(List<double> pressures, List<int> time) {
    return new SimpleTimeSeriesChart(
      _createData(pressures, time),
      animate: false
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      animate: animate,
    );
  }

  static List<charts.Series<TimeSeriesPressures, double>> _createData(List<double> pressures, List<int> time) {
    var data = <TimeSeriesPressures>[];
    for (int i = 0; i < time.length; i++) {
      if (i < pressures.length) {
        data.add(TimeSeriesPressures(time[i] / 1000, pressures[i]));
      }
    }

    return [
      new charts.Series<TimeSeriesPressures, double>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesPressures sales, _) => sales.time,
        measureFn: (TimeSeriesPressures sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

class TimeSeriesPressures {
  final double time;
  final double sales;

  TimeSeriesPressures(this.time, this.sales);
}