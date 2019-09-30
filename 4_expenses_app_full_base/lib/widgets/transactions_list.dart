import 'package:flutter/material.dart';
//package used to manage date formats
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _transactionsList;
  final void Function(String id) _deleteTransaction;

  TransactionsList(this._transactionsList, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return // ***** TRANSACTIONS LIST *****
        //
        // This code also works but is unnecessary in this case because _transactionsList.map().toList()
        // already returns a List<Widgets>, which is what the "children" requires
        //
        // Column(
        //   children: <Widget>[
        //     ..._transactionsList.map((tx) {
        //       return Card(
        //         child: Text(tx.title),
        //       );
        //     }).toList(),
        //   ],
        // ),
        Container(
          height: 390,
          child: _transactionsList.isEmpty
              ? Column(
                  children: <Widget>[
                    Text(
                      'Expenses List is Empty...\nAdd a new Transaction by clicking on the\n+ button!',
                      style: Theme.of(context).textTheme.title,
                      textAlign: TextAlign.center,
                    ),
                    // Sizebox is useful to make blank Widgets to help positions uor other widgets without touching margin
                    // or padding
                    SizedBox(
                      height: 5,
                    ),
                    // to add an image, i have added it to assets/images. Then added the image path to assets
                    // in pubspec.yaml
                    // fit permits to make the image fit into the screen
                    Image.asset(
                      'assets/images/dog1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],
                )
              :
              // to make a widget scrollable we need to set a fixed heigth to the parent widget
              // child: SingleChildScrollView( Column(...
              // ListView is better to use that the SingleChildScrollView/Column combination
              // child: ListView(
              // ListView.Builder() is even better because it permits to render only the widgets that have to appear on screen
              // with ListView,the problem is that all widgets are rendered even tif they are off-screen
              // which is no optimized at all if we work with very long lists
              //
              // with ListView.builder(), the technique with coulum(children: List<Widgets>) and then
              // _transactionsList.map((tx){render widget}).toList() is not required anymore, because ListView.builder(0) does the job
              ListView.builder(
                  // itemCount permits to tell itemBuilder how much widgets have to be built at the end
                  itemCount: _transactionsList.length,
                  // itemBuilder is required: it permits to build each widget
                  // indedx is very impoortant here, it's giver by itemBuilder and permits to get an index of current building widget
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      // ListTile widget fit particularly well to diplay the outcome of a looping though a list
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 40,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: FittedBox(
                              child: Text(
                                  '\$${_transactionsList[index].amount.toStringAsFixed(2)}'),
                            ),
                          ),
                        ),
                        title: Text(
                          _transactionsList[index].title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd()
                              .add_jm()
                              .format(_transactionsList[index].date),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 15),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              _deleteTransaction(_transactionsList[index].id),
                        ),
                      ),
                    );

                    // BELOW IS WHAT WAS DONE BEFORE WE MAKE IT A ListTile Widget
                    // ListTile positions elements easily, like leading widget, then title and subtitle
                    // hence there's no need to set rows and columns by ourself
                    //
                    //
                    // return Card(
                    //   elevation: 5,
                    //   child: Row(
                    //     children: <Widget>[
                    //       // ***** DOLLAR VALUE *****
                    //       Container(
                    //         margin: EdgeInsets.symmetric(
                    //             vertical: 15, horizontal: 15),
                    //         decoration: BoxDecoration(
                    //           border: Border.all(
                    //             color: Theme.of(context).accentColor,
                    //             width: 2,
                    //             style: BorderStyle.solid,
                    //           ),
                    //         ),
                    //         padding: EdgeInsets.all(10),
                    //         child: Text(
                    //           // $ is a reserved sign, that's why we use \$ to tell Dart to escape the meaning of $ and display it as a character
                    //           // toStringAsFixed() takes an int and permits to define number of digits to display for a double number
                    //           '\$${_transactionsList[index].amount.toStringAsFixed(2)}',
                    //           style: TextStyle(
                    //             color: Theme.of(context).primaryColorDark,
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),

                    //       // ***** TRANSACTION NAME & DATE *****
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: <Widget>[
                    //           Text(
                    //             _transactionsList[index].title,
                    //             style: Theme.of(context).textTheme.title,
                    //           ),
                    //           Text(
                    //             // format method converts DateTime into more readable string
                    //             // DateFormat('yyyy-MM-dd _ hh:mm a').format(tx.date),
                    //             DateFormat.yMMMd()
                    //                 .add_jm()
                    //                 .format(_transactionsList[index].date),
                    //             style: TextStyle(
                    //                 color: Theme.of(context).primaryColorDark,
                    //                 fontSize: 15),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // );
                  },
                ),
        );
  }
}
