import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import '../../../models/studentModels/PointsHistory.dart';
import '../../../providers/studentProviders/points.dart';

class ProgressionGraph extends StatelessWidget {
  // graphs documentaition:
  // https://www.syncfusion.com/flutter-widgets/flutter-charts/chart-types/spline-area-chart
  const ProgressionGraph({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Points pointsProvider = Provider.of<Points>(context, listen: false);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: constraints.maxWidth * 0.6,
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                primaryXAxis: DateTimeAxis(
                  intervalType: DateTimeIntervalType.days,
                  majorGridLines: MajorGridLines(width: 0),
                  axisLine: AxisLine(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines: MajorGridLines(width: 0),
                  axisLine: AxisLine(width: 0),
                ),
                series: <SplineAreaSeries<PointsHistory, DateTime>>[
                  SplineAreaSeries<PointsHistory, DateTime>(
                      dataSource: pointsProvider.history,
                      color: Colors.amber,
                      xValueMapper: (PointsHistory historyMark, _) =>
                          historyMark.date,
                      yValueMapper: (PointsHistory historyMark, _) =>
                          historyMark.value)
                ],
              ),
            ),
            CircularPercentIndicator(
              radius: constraints.maxWidth * 0.25,
              lineWidth: 12,
              percent: 0.7,
              center: Text("70%"),
              progressColor: Colors.amber,
            )
          ],
        ),
      );
    });
  }
}
