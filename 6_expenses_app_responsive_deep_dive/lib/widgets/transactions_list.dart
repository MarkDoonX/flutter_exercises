import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _transactionsList;
  final void Function(String id) _deleteTransaction;

  TransactionsList(this._transactionsList, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    print('build() Transactions_list Stateless');
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
      // instead of setting a fixed heigh, here we set a responsive height
      // we multiply it by something between 0 and 1 to give it a % of screen space to take
      // since the result of the MediaQuery.size is the height of the whole device
      // height: MediaQuery.of(context).size.height * 0.7,
      child: _transactionsList.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: constraints.maxHeight * 0.3,
                      child: Text(
                        'Expenses List is Empty...\nAdd a new Transaction by clicking on the\n+ button!',
                        style: Theme.of(context).textTheme.title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Sizebox is useful to make blank Widgets to help positions uor other widgets without touching margin
                    // or padding
                    SizedBox(
                      height: constraints.maxHeight * 0.1,
                    ),
                    // to add an image, i have added it to assets/images. Then added the image path to assets
                    // in pubspec.yaml
                    // fit permits to make the image fit into the screen
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/dog1.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
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

          /// ListView.builder is bugged when it comes to Keys
          /// Hence, for the example i'll use simple ListView
          ///
          // ListView.builder(
          //     // itemCount permits to tell itemBuilder how much widgets have to be built at the end
          //     itemCount: _transactionsList.length,
          //     // itemBuilder is required: it permits to build each widget
          //     // index is very impoortant here, it's giver by itemBuilder and permits to get an index of current building widget
          //     itemBuilder: (context, index) {
          //       // to extract this ListItem from here as an independant widget, i have used Extract from frefactor option
          //       // still had to make some manual modifications but it really permits to quickly extract widgets by
          //       // creating the new widget and asigning needed parameters through the constructor
          //       // in this case had to pass _transactionsList[index], instead of index, to return 1 ListItem by index
          //       return TransactionItem(
          //         // key: UniqueKey(),
          //         transaction: _transactionsList[index],
          //         deleteTransaction: _deleteTransaction,
          //       );
          //     },
          //   ),

          ListView(
              children: _transactionsList.map((tx) {
              return TransactionItem(
                // here we set a unique Key. we take Transaction's Id as the Key
                // now, flutter will check Widget type AND Key to decide which State refers to which widget
                key: ValueKey(tx.id),
                transaction: tx,
                deleteTransaction: _deleteTransaction,
              );
            }).toList()),
    );
  }
}
