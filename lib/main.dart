import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/transaction.dart';
import 'package:flutter_complete_guide/transaction_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'new shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'new jacket', amount: 99.99, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'new computer', amount: 2069.99, date: DateTime.now()),
    Transaction(
        id: 't4', title: 'new watch', amount: 169.99, date: DateTime.now()),
    Transaction(
        id: 't5', title: 'new shirt', amount: 49.99, date: DateTime.now()),
    Transaction(
        id: 't6', title: 'new food', amount: 39.99, date: DateTime.now()),
  ];

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            // this card take it's child size
            color: Colors.blue,
            elevation: 5,
            child: Container(
              width: double.infinity,
              //height: 100,
              child: Text(
                  'CHART!'), // this text size depends on its String we give so to set size we need container wraped around it
            ),
          ),
          Card(
            child: Container(
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Enter your title',
                    ),
                  ),
                  TextField(
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'Enter your amount',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print(
                          "${titleController.text}\n${amountController.text}");
                    },
                    child: Text('Add transaction'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.purple),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: transactions
                .map(
                  (transaction) => TransactionCard(transaction: transaction),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
