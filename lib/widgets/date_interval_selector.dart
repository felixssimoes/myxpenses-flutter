import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/providers/date_interval.provider.dart';
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
                  context,
                  dateInterval.type == IntevalType.Day,
                  'Day',
                  () => dateInterval.setType(IntevalType.Day),
                ),
                _buildButton(
                  context,
                  dateInterval.type == IntevalType.Week,
                  'Week',
                  () => dateInterval.setType(IntevalType.Week),
                ),
                _buildButton(
                  context,
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

  Widget _buildButton(
    BuildContext context,
    bool active,
    String title,
    Function onPressed,
  ) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        color: active ? theme.accentColor : theme.disabledColor,
        child: FlatButton(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: active ? Colors.black : theme.buttonColor,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
