import 'package:flutter/material.dart';

class EntryRowItem extends StatelessWidget {
  final String title;
  final String value;
  final String units;

  EntryRowItem({
    this.title,
    this.value,
    this.units,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 1),
          padding: EdgeInsets.all(2),
          child: Column(
            children: <Widget>[
              Text(
                this.title,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
              ),
              Text(
                this.value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
              ),
              Text(
                this.units,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
