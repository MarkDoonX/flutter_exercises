import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double totalDailyExpenses;
  final String weekDay;
  final double dailyExpensesRatioOfTotal;

  const ChartBar(
      this.totalDailyExpenses, this.weekDay, this.dailyExpensesRatioOfTotal);

  @override
  Widget build(BuildContext context) {
    print('build() Chart_bar stateless');
    // LayoutBuilder here permits to access constraints property, which is inherited from the parent (CharBar)
    // and can be usedd to dynamically size the elements in the following returned widgets.
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            // FittedBox Widget is very useful to prevent a child widget to push the sides of its prent's borders
            // if it doesnt fit in it.
            // Instead, the child widget in the FittedBox widget will automatically resize to fit it's parent Widget.
            // In this case, the text's fontSize would lower if the text doest fit.
            Container(
              // setting height to avoid resizing if long prices are entered
              // we dynamically size this widget by calling constraints.maxheight, which refers to the current
              // total height of the ChartBar, which itself adapts to the Chart's Row()
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text("\$${totalDailyExpenses.toStringAsFixed(0)}"),
              ),
            ),
            // SizedBox permits to add some psacing without using padding or margin here
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            // Stack permits to position widgets on top of each others (from bottom to up on Z-index)
            Container(
              height: constraints.maxHeight * 0.6,
              width: 25,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 1),
                    // this width is set to not hide the border of the parent Container
                    width: 23,
                    // FractionallySizedBox Widget is very useful to be able to proportionally size a widget
                    // depending on the parent widget dimensions
                    child: FractionallySizedBox(
                      // widthfactor or heightfactor of 1.0 means to take 100% of parent Widget's dimensions
                      widthFactor: 1.0,
                      heightFactor: dailyExpensesRatioOfTotal,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  // Center widget permits to easily center widget into the parent widget
                  Center(
                    // RotatedBox permmits to rotate a widget by 90° at a time
                    child: RotatedBox(
                      quarterTurns: 3,
                      child:
                          Text("${(dailyExpensesRatioOfTotal * 100).round()}%"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(weekDay),
              ),
            ),
          ],
        );
      },
    );
  }
}
