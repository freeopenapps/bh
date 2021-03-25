import 'package:flutter/material.dart';
import '../theme.dart';
import '../constants.dart';

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
          margin: EdgeInsets.symmetric(
            vertical: EntryRowItemConsts.containerMarginVertical,
            horizontal: EntryRowItemConsts.containerMarginHorizontal,
          ),
          padding: EdgeInsets.all(EntryRowItemConsts.containerPadding),
          child: Column(
            children: <Widget>[
              Text(
                this.title,
                style: theme.textTheme.headline4,
              ),
              Text(
                this.value,
                style: theme.textTheme.headline3,
              ),
              Text(
                this.units,
                style: theme.textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
