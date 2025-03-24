import 'package:flutter/material.dart';
import 'package:gcc_portal/models/dashboard_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

class DoughnutChartWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String total;
  final bool isTrade;
  final List<dynamic>? dataSource;

  const DoughnutChartWidget({
    super.key,
    required this.color,
    required this.title,
    required this.total,
    required this.isTrade,
    required this.dataSource,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      constraints: const BoxConstraints(minHeight: 300),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child:             Text(
              title,
              textAlign: TextAlign.center,
              style:  TextStyle(
                color: color,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            )
            // Text(
            //   title,
            //   textAlign: TextAlign.center,
            //   style: const TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 16),
            // ),
          ),
          SfCircularChart(
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'মোট\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: total,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              legend: const Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  alignment: ChartAlignment.near,
                  position: LegendPosition.bottom),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CircularSeries<dynamic, String>>[
                DoughnutSeries<dynamic, String>(
                  innerRadius: '80%',
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  cornerStyle: CornerStyle.bothCurve,
                  dataSource: dataSource,
                  // xValueMapper: (ChartData data, _) => data.x,
                  xValueMapper: (data, _) => data['name'],
                  yValueMapper: (data, _) => isTrade
                      ? data['total_trade_license']
                      : data['tax_amount'],
                  pointColorMapper: (data, _) => Color(int.parse(
                          data['background_color'].substring(1, 7),
                          radix: 16) +
                      0xFF000000),
                )
              ]),
        ],
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  final Color color;
  final String title;
  final List<String> labels;
  final List<Dataset> datasets;
  final TooltipBehavior? tooltip;

  const BarChartWidget({
    super.key,
    required this.color,
    required this.title,
    required this.labels,
    required this.datasets,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    List<ColumnSeries<ChartData, String>> seriesList = datasets.map((dataset) {
      List<ChartData> chartDataList = [];
      for (int i = 0; i < labels.length; i++) {
        chartDataList
            .add(ChartData(labels[i], dataset.data[i].toDouble() ?? 0.0));
      }

      return ColumnSeries<ChartData, String>(
        dataLabelSettings: const DataLabelSettings(
          isVisible: false,
        ),
        dataSource: chartDataList,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        name: dataset.label,
        color: _getColorForDataset(dataset.backgroundColor),
        // Bar thickness
      );
    }).toList();

    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      constraints: const BoxConstraints(minHeight: 300),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child:
            Text(
              title,
              textAlign: TextAlign.center,
              style:  TextStyle(
                color: color,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                axisLine: const AxisLine(color: Colors.grey),
                maximumLabels: labels.length,
                labelIntersectAction: AxisLabelIntersectAction.rotate45,
                labelStyle: const TextStyle(
                  fontSize: 10,
                ),
              ),
              legend: Legend(
                legendItemBuilder:
                    (String name, dynamic series, dynamic point, int index) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 16,
                        height: 8,
                        color: _getColorForDataset(
                            datasets[index].backgroundColor),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                alignment: ChartAlignment.near,
                position: LegendPosition.bottom,
              ),
              primaryYAxis: const NumericAxis(
                axisLine: AxisLine(color: Colors.grey),
                majorGridLines: MajorGridLines(width: 1),
              ),
              tooltipBehavior: tooltip,
              series: seriesList,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForDataset(String colorStr) {
    final regex = RegExp(r'rgba\((\d+), (\d+), (\d+), (\d+\.\d+)\)');
    final match = regex.firstMatch(colorStr);
    if (match != null) {
      final r = int.parse(match.group(1)!);
      final g = int.parse(match.group(2)!);
      final b = int.parse(match.group(3)!);
      final a = double.parse(match.group(4)!);
      return Color.fromRGBO(r, g, b, a);
    }
    return Colors.black;
  }
}
