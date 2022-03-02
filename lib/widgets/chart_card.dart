import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // this card take it's child size
      color: Colors.blue,
      elevation: 5,
      child: Container(
        width: double.infinity,
        //height: 100,
        child: Text(
            'CHART!'), // this text size depends on its String we give so to set size we need container wraped around it
      ),
    );
  }
}
