import 'package:flutter/material.dart';
import '../../models/expense.dart';
import 'expense_form.dart';
import 'expense_item.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _expenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void onAddClicked(BuildContext context) async {
    final newExpense = await showModalBottomSheet<Expense>(
      isScrollControlled: false,
      context: context,
      builder: (c) => Center(child: ExpenseForm()),
    );

    if (newExpense != null) {
      setState(() {
        _expenses.add(newExpense);
      });
    }
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _expenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => {onAddClicked(context)},
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
      ),
      body: ListView.builder(
        itemCount: _expenses.length,
        itemBuilder: (context, index) {
          final expense = _expenses[index];
          return Dismissible(
            key: ValueKey(expense.id),
            onDismissed: (direction) {
              _removeExpense(expense);
            },
            child: ExpenseItem(expense: expense),
          );
        },
      ),
    );
  }
}

