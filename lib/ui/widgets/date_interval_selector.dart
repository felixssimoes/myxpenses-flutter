import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/data/providers/date_interval.provider.dart';
import 'package:provider/provider.dart';

class DateIntervalSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DateIntervalProvider>(
      builder: (
        BuildContext context,
        DateIntervalProvider dateInterval,
        Widget child,
      ) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildButton(
                  dateInterval.type == IntevalType.Day,
                  'Day',
                  () => dateInterval.setType(IntevalType.Day),
                ),
                _buildButton(
                  dateInterval.type == IntevalType.Week,
                  'Week',
                  () => dateInterval.setType(IntevalType.Week),
                ),
                _buildButton(
                  dateInterval.type == IntevalType.Month,
                  'Month',
                  () => dateInterval.setType(IntevalType.Month),
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: () => dateInterval.selectPreviousInterval(),
                ),
                Expanded(
                  child: Text(
                    'From: ${DateFormat('dd/MM/yyy').format(dateInterval.startDate)} - To: ${DateFormat('dd/MM/yyy').format(dateInterval.endDate.subtract(Duration(microseconds: 1)))}',
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () => dateInterval.selectNextInterval(),
                ),
              ],
            ),
            Divider(),
          ],
        );
      },
    );
  }

  Widget _buildButton(bool active, String title, Function onPressed) {
    return Expanded(
      child: Container(
        color: active ? Colors.green : Colors.grey,
        child: FlatButton(
          child: Text(title),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
