import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:workout_tracker/datetime/date_time.dart';

import '../constants/color_constants.dart';
import '../constants/decoration_constants.dart';

class MyHeatMap extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDateYYYYMMDD;

  const MyHeatMap({
    Key? key,
    required this.datasets,
    required this.startDateYYYYMMDD,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding25,
      child: HeatMap(
        startDate: createDateTimeObject(startDateYYYYMMDD),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: grey300,
        textColor: Colors.black,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {1: beige300},
      ),
    );
  }
}
