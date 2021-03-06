import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _dateIntervalPreferenceKey = 'com.myxpenses.dateInterval';

enum IntevalType { Day, Week, Month }

class DateIntervalProvider extends ChangeNotifier {
  IntevalType _type = IntevalType.Day;
  DateTime _startDate;
  DateTime _endDate;

  IntevalType get type => _type;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;

  DateIntervalProvider() {
    _startDate = DateTime.now();
    _endDate = DateTime.now();
    _loadState();
  }

  void setType(IntevalType newType) {
    _type = newType;
    _updateDates();
    _saveState();
    notifyListeners();
  }

  void selectPreviousInterval() {
    switch (_type) {
      case IntevalType.Day:
        _endDate = _startDate;
        _startDate = _startDate.subtract(Duration(days: 1));
        break;
      case IntevalType.Week:
        _endDate = _startDate;
        _startDate = _startDate.subtract(Duration(days: 7));
        break;
      case IntevalType.Month:
        _endDate = _startDate;
        _startDate = DateTime(_startDate.year, _startDate.month - 1);
        break;
    }
    notifyListeners();
  }

  void selectNextInterval() {
    switch (_type) {
      case IntevalType.Day:
        _startDate = _startDate.add(Duration(days: 1));
        _endDate = _startDate.add(Duration(days: 1));
        break;
      case IntevalType.Week:
        _startDate = _startDate.add(Duration(days: 7));
        _endDate = _startDate.add(Duration(days: 7));
        break;
      case IntevalType.Month:
        _startDate = DateTime(_startDate.year, _startDate.month + 1);
        _endDate = DateTime(_startDate.year, _startDate.month + 1);
        break;
    }
    notifyListeners();
  }

  void _updateDates() {
    final now = DateTime.now();
    switch (_type) {
      case IntevalType.Day:
        _startDate = DateTime(now.year, now.month, now.day);
        _endDate = _startDate.add(Duration(days: 1));
        break;

      case IntevalType.Week:
        final today = DateTime(now.year, now.month, now.day);
        _startDate = today.subtract(new Duration(days: today.weekday));
        _endDate = _startDate.add(Duration(days: 7));
        break;

      case IntevalType.Month:
        _startDate = DateTime(now.year, now.month);
        _endDate = DateTime(now.year, now.month + 1);
        break;
    }
  }

  Future<void> _loadState() async {
    final preferences = await SharedPreferences.getInstance();
    final typeString = preferences.getString(_dateIntervalPreferenceKey);
    switch (typeString) {
      case 'day':
        _type = IntevalType.Day;
        break;
      case 'week':
        _type = IntevalType.Week;
        break;
      case 'month':
        _type = IntevalType.Month;
        break;
    }
    _updateDates();
    notifyListeners();
  }

  Future<void> _saveState() async {
    final preferences = await SharedPreferences.getInstance();
    var typeString;
    switch (_type) {
      case IntevalType.Day:
        typeString = 'day';
        break;
      case IntevalType.Week:
        typeString = 'week';
        break;
      case IntevalType.Month:
        typeString = 'month';
    }
    preferences.setString(_dateIntervalPreferenceKey, typeString);
  }
}
