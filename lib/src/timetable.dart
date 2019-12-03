import 'package:flutter/material.dart';
import 'package:weekly_timetable/src/cell.dart';
import 'package:weekly_timetable/src/header.dart';
import 'package:weekly_timetable/src/indicator.dart';
import 'package:weekly_timetable/src/weekly_times.dart';

class WeeklyTimeTable extends StatefulWidget {
  final ValueChanged<Map<int, List<int>>> onValueChanged;
  final Color cellColor;
  final Color cellSelectedColor;
  final Color boarderColor;
  final Map<int, List<int>> initialSchedule;
  final bool draggable;

  WeeklyTimeTable({
    this.cellColor = Colors.white,
    this.cellSelectedColor = Colors.black,
    this.boarderColor = Colors.grey,
    this.initialSchedule = const {
      0: [],
      1: [],
      2: [],
      3: [],
      4: [],
      5: [],
      6: [],
    },
    this.draggable = false,
    this.onValueChanged,
  });

  @override
  _WeeklyTimeTableState createState() => _WeeklyTimeTableState();
}

class _WeeklyTimeTableState extends State<WeeklyTimeTable> {
  Map<int, List<int>> selected = {
    0: [],
    1: [],
    2: [],
    3: [],
    4: [],
    5: [],
    6: [],
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Header(),
        Expanded(
          child: ListView.builder(
            itemCount: WeeklyTimes.times.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              List<Widget> children = [];
              children.add(Indicator(WeeklyTimes.times[index]));
              children.addAll(
                List.generate(
                  WeeklyTimes.dates.length - 1,
                      (i) =>
                      Cell(
                        day: i,
                        timeRange: index,
                        isSelected: selected[i].contains(index),
                        onCellTapped: onCellTapped,
                        cellColor: widget.cellColor,
                        cellSelectedColor: widget.cellSelectedColor,
                        boarderColor: widget.boarderColor,
                      ),
                ),
              );
              return Row(children: children);
            },
          ),
        ),
      ],
    );
  }

  onCellTapped(int day, int timeRange, bool nextSelectedState) {
    setState(() {
      if (!nextSelectedState) {
        selected[day].add(timeRange);
      } else {
        selected[day].remove(timeRange);
      }
    });
    widget.onValueChanged(selected);
  }
}
