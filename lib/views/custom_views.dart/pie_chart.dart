import 'package:expense_tracker_app/view_model/expense_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({
    super.key,
  });

  @override
  State<PieChartSample2> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;
  late ExpenseViewModel viewModel;
  List<Color> colorList = [
    Colors.black26,
    Colors.blue,
    Colors.brown,
    Colors.pink,
    Colors.yellow,
    Colors.green,
    Colors.indigo,
    Colors.purple
  ];
  List<String> categories = [
    'Food',
    'Transportation',
    'Subcriptions',
    'Fuel',
    'Clothing',
    'Rent',
    'Miscellaneous',
    'Others'
  ];

  @override
  Widget build(BuildContext context) {
    viewModel = context.watch<ExpenseViewModel>();
    return AspectRatio(
      aspectRatio: 1.95,
      child: viewModel.expenses.isEmpty
          ? const CircularProgressIndicator.adaptive()
          : Row(
              children: <Widget>[
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...categories.map(
                        (e) => Indicator(
                          color: colorList[categories.indexOf(e)],
                          text: e,
                          isSquare: true,
                        ),
                      )
                    ]),
                const SizedBox(
                  width: 0,
                ),
              ],
            ),
    );
  }

  List<PieChartSectionData> showingSections() {
    Map<String, num> data = {};
    num count = 0;
    for (var i = 0; i < categories.length; i++) {
      for (var element in viewModel.expenses) {
        if (element.expenseCategory == categories[i]) {
          count = count + double.parse(element.amount);
        }
      }
      data[categories[i]] = count;
      count = 0;
    }
    var total = data.values.sum;
    var data1 = data.entries.map((e) {
      return e.value == 0
          ? data[e.key] = 0
          : data[e.key] =
              double.parse(((e.value / total) * 100).toStringAsFixed(2));
    }).toList();

    List<PieChartSectionData> pieChartSectionData = [];
    for (var i = 0; i < categories.length; i++) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 0)];
      pieChartSectionData.add(PieChartSectionData(
          color: colorList[i],
          value: data1[i].toDouble(),
          title: '${data1[i].toDouble()}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            shadows: shadows,
          )));
    }

    return pieChartSectionData;
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        )
      ],
    );
  }
}
