import 'package:flutter/material.dart';

class TextFieldCard extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  const TextFieldCard({Key key, this.titleController, this.amountController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                print("${titleController.text}\n${amountController.text}");
              },
              child: Text('Add transaction'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
