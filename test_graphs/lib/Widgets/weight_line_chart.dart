import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../weight_observations_JUNK_DATA.dart';
import '../models/weight_observation.dart';
import '../helpers/chart_helper.dart';

GlobalKey _keySpot = GlobalKey();

class WeightLineChart extends StatefulWidget {
  @override
  _WeightLineChartState createState() => _WeightLineChartState();
}

class _WeightLineChartState extends State<WeightLineChart> {
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: 330,
            padding: EdgeInsets.symmetric(vertical: 60),
            child: FlChart(swapAnimationDuration: Duration(milliseconds: 1000),
              chart: LineChart(
                showAvg
                    ? data1(weightObservations4)
                    : data1(weightObservations1),
              ),
            ),
          ),
          SizedBox(
            width: 60,
            height: 34,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  showAvg = !showAvg;
                });
              },
              child: Text(
                'avg',
                style: TextStyle(
                    fontSize: 12,
                    color:
                        showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


LineChartData data1(List<WeightObservation> weightObservations) {
  final double lowestOservationValue =
      getLowestObservationValue(weightObservations);
  final double highestObservationValue =
      getHighestObservationValue(weightObservations);
  final List<FlSpot> dotsToDraw = createDots(weightObservations);

  Offset spotOffsetsList;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  return LineChartData(
    /// permits to not cut what goes out of the chart
    clipToBorder: false,

    /// permits to hide grid
    gridData: FlGridData(show: false),
    lineTouchData: LineTouchData(
        touchTooltipData: TouchTooltipData(
            tooltipBgColor: Colors.blueAccent,
            getTooltipItems: (List<TouchedSpot> spots) {
              return spots.map((spot) {
                final flSpot = spot.spot;
                spotOffsetsList = spot.offset;
                print(spotOffsetsList);

                return TooltipItem(
                  '${flSpot.y} Kg',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            })),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(showTitles: false),
      leftTitles: SideTitles(
        showTitles: false,
        textStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 85:
              return '10k';
            case 86:
              return '30k';
            case 87:
              return '50k';
          }
          return '';
        },
        reservedSize: 30,
        margin: 0,
      ),
    ),
    borderData: FlBorderData(
      show: false,
      // border: Border.all(color: const Color(0xff37434d), width: 5),
    ),
    minX: 0,
    // amount of x dots depends on observations amount
    maxX: weightObservations.length.toDouble() - 2,
    minY: lowestOservationValue - 6,
    maxY: highestObservationValue,
    lineBarsData: [
      LineChartBarData(
        show: true,
        spots: dotsToDraw,
        isCurved: true,
        colors: gradientColors,
        // thickness of the line
        barWidth: 8,
        isStrokeCapRound: false,
        dotData: const FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors:
              gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
      ),
    ],
  );
}
