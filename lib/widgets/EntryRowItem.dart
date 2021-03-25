import 'package:flutter/material.dart';
import '../theme.dart';

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
    final theme = mobileTheme();
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
                style: theme.textTheme.headline3,
              ),
              Text(
                this.value,
                style: theme.textTheme.headline1.copyWith(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                this.units,
                style: theme.textTheme.headline3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
