import 'package:flutter/material.dart';


class SwitchTabs extends StatefulWidget {
  SwitchTabs(
      {@required this.switchTabsMode, @required this.isBottomTabsDisplayed});

  final void Function(bool boolState) switchTabsMode;
  final bool isBottomTabsDisplayed;

  @override
  _SwitchTabsState createState() => _SwitchTabsState();
}

class _SwitchTabsState extends State<SwitchTabs> {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text('Tabs mode'),
      Switch(
        value: widget.isBottomTabsDisplayed,
        onChanged: (bool newBoolean) {
          widget.switchTabsMode(newBoolean);
        },
      ),
    ]);
  }
}
