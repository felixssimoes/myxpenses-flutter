import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:myxpenses/models/expense.model.dart';

class ExpenseFormData {
  String category;
  DateTime date;
  double value;
}

class ExpenseForm extends StatefulWidget {
  final Expense expense;
  final Function(ExpenseFormData) onSaveExpense;

  ExpenseForm({
    this.expense,
    @required this.onSaveExpense,
  });

  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _formData = ExpenseFormData();
  final _valueFocus = FocusNode();
  final _valueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _formData.category = widget.expense.category;
      _formData.date = widget.expense.date;
      _valueController.text = widget.expense.value.toStringAsFixed(2);
    } else {
      _formData.category = '';
      _formData.date = DateTime.now();
      _valueController.text = '0.00';
    }
    _valueFocus.addListener(_valueFocusListener);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildCategoryField(context),
          _buildDateField(context),
          _buildValueField(context),
          _buildSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildCategoryField(BuildContext context) {
    return TextFormField(
      autofocus: true,
      initialValue: _formData.category,
      decoration: InputDecoration(
        labelText: 'Category',
        icon: Icon(Icons.category),
      ),
      onSaved: (value) => _formData.category = value,
      validator: (value) =>
          value.isEmpty ? 'Expense category is required.' : null,
    );
  }

  Widget _buildDateField(BuildContext context) {
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    return DateTimeField(
      readOnly: true,
      format: dateFormat,
      initialValue: _formData.date,
      validator: (value) {
        if (value == null) {
          return 'Expense date is required';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Date',
        icon: Icon(Icons.calendar_today),
      ),
      onChanged: (date) => _formData.date = date,
      onShowPicker: (BuildContext context, DateTime currentValue) async {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime.now());
      },
    );
  }

  Widget _buildValueField(BuildContext context) {
    return TextFormField(
      controller: _valueController,
      focusNode: _valueFocus,
      decoration: InputDecoration(
        labelText: 'Value',
        icon: Icon(Icons.monetization_on),
      ),
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d?\d?)?'))
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) =>
          (double.tryParse(value) ?? 0) <= 0 ? 'Invalid expense value' : null,
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    final title = widget.expense == null ? 'Create Expense' : 'Update Expense';
    return RaisedButton(
      child: Text(title),
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
      onPressed: () {
        if (!_formKey.currentState.validate()) return;
        _formKey.currentState.save();
        _formData.value = double.tryParse(_valueController.text) ?? 0;
        widget.onSaveExpense(_formData);
      },
    );
  }

  void _valueFocusListener() {
    final value = double.tryParse(_valueController.text);
    if (value != null && value > 0) {
      _valueController.text = value.toStringAsFixed(2);
    } else {
      _valueController.text = _valueFocus.hasFocus ? '' : '0.00';
    }
  }
}
