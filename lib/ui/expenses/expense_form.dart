import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController(); // []
  Category _selectedCategory = Category.leisure; // Added state for category

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
    _valueController.dispose(); // []
  }

  void onCreate() {
    //  1 Build an expense
    String title = _titleController.text;
    DateTime date = DateTime.now();

    final enteredAmount = double.tryParse(_valueController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (title.trim().isEmpty || amountIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title and amount was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    // Creating newExpense with _selectedCategory
    final newExpense = Expense(
      title: title,
      amount: enteredAmount,
      date: date,
      category: _selectedCategory,
    );

    Navigator.pop(context, newExpense);
  }

  void onCancel() {
    // Close the modal
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text("Title")),
            maxLength: 50,
          ),
          TextField(
            controller: _valueController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text('Amount'),
              prefixText: '\$',
            ),
          ),

          // Added DropdownButton for category selection
          const SizedBox(height: 16),
          DropdownButton<Category>(
            value: _selectedCategory,
            items: Category.values
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category.name.toUpperCase(),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(onPressed: onCancel, child: Text("Cancel")),
              SizedBox(width: 10),
              ElevatedButton(onPressed: onCreate, child: Text("Create")),
            ],
          )
        ],
      ),
    );
  }
}
