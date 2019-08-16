import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/providers/expenses.provider.dart';
import 'package:provider/provider.dart';

class ExpenseListItem extends StatelessWidget {
  final String expenseId;
  final Function onSelectExpense;

  const ExpenseListItem({
    Key key,
    @required this.expenseId,
    this.onSelectExpense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expense = Provider.of<ExpensesProvider>(context).findById(expenseId);
    return ListTile(
      title: Text(expense.category),
      subtitle: Text(DateFormat('dd/MM/yyyy').format(expense.date)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            NumberFormat.currency(name: 'EUR ').format(expense.value),
            style: TextStyle(
              color: Colors.brown,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => onSelectExpense(),
    );
  }
}
