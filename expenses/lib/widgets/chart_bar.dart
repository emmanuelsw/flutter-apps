import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount, total;

  ChartBar(this.label, this.amount, this.total);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(
          child: Text(
            '\$${amount.toStringAsFixed(0)}',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: total,
                child: Container(
                  width: 10,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.purple[400], Colors.deepPurple[900]]
                      )),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        )
      ],
    );
  }
}
