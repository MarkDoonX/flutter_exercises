import 'package:flutter/material.dart';

import './widgets/transactions_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      // the Theme permits to store colors in some properties and use it everywhere we want
      // primarySwatch permits to unlock shades of the defined color.
      // => using: Theme.of(context).primaryColor
      // or derived shades of the color:
      // =>  heme.of(context).primaryColorLight for example
      theme: ThemeData(
        // to use primarySwatch when primarycolor is set, use promaryColorDark or primaryColorLight
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.amberAccent[100],
        // primaryColor: Colors.black,
        cardColor: Colors.white,
        errorColor: Colors.red,

        // importing font from pubspec.yaml, which links with fonts in assets/fonts
        // fontFamily is the default font for the whole app
        // fontFamily: 'OpenSans',

        // Below, we are setting a font and size for AppBar's title (text that is markedd as title)
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  // using the bold version of our own font
                  fontWeight: FontWeight.bold,
                  // color: Colors.black,
                ),
              ),
        ),
        // Below, giving a theme for all the titles in the app.
        //
        textTheme: TextTheme(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactionsList = [
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 50,
      date: DateTime(2019, 8, 15),
    ),
    Transaction(
      id: 't2',
      title: 'Grocery',
      amount: 100,
      date: DateTime(2019, 8, 14),
    ),
    Transaction(
      id: 't3',
      title: 'Darts',
      amount: 200,
      date: DateTime(2019, 8, 13),
    ),
    Transaction(
      id: 't4',
      title: 'Flowers',
      amount: 50,
      date: DateTime(2019, 8, 12),
    ),
    Transaction(
      id: 't5',
      title: 'Flowers',
      amount: 50,
      date: DateTime(2019, 8, 11),
    ),Transaction(
      id: 't6',
      title: 'Flowers',
      amount: 50,
      date: DateTime(2019, 8, 10),
    ),Transaction(
      id: 't7',
      title: 'Flowers',
      amount: 50,
      date: DateTime(2019, 8, 09),
    ),
  ];

  // returns a list where Transactions are not older than 7 days
  List<Transaction> get recentTransactionsList {
    return _transactionsList.where((tx) {
      DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 7));
      if (tx.date.compareTo(oneWeekAgo) >= 0) return true;
      return false;
    }).toList();
  }

  void _addNewTransaction({String txTitle, double txAmount, DateTime txDate}) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _transactionsList.add(newTx);
    });
    print("Print from _addNewTransaction in main.dart ${DateTime.now()}");
  }

  void _deleteTransaction(String id){
    setState(() {
      _transactionsList.removeWhere((tx) => tx.id == id);
    });
  }

  // This Method permits to show the NewTransaction Widget that is hiden and will appear from bottom of the sheet
  // So we don't need to place NewTransaction Widget in the  Widgets tree anymore
  // We differenctiate contextes ctx an bCtx. ctx is global context, bCtx is builder's context
  void _startAddNexTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      // bCtx is not used an dautomatically filledd by Flutter. We could put a "_" instead.
      builder: (bCtx) {
        // We wrap NewTransaction into a GestureDetector widget which permits to contraoll what happens on
        // NewTransaction Widget when we tap on it for exemple.
        // - Here we put a blank function to onTap to avoid that the NewTransacion Widget reloads when we tap on it
        // - behavior: HitTestBehavior.opaque permits to make the NewTransaction widget opaque, which prevents
        //   that a click on it would actually also make a click on the sheet below, which would reload the
        //   NewTransaction Widget as well.
        //
        // Still we have a problem: when we fill the title then the amount, the Widget reloads...
        // for this we need to change NewTransaction Widget from a Stateless to a Statefull Widget.
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  // TESTING to see DateTime
  void _printDateTime() {
    for (int i = 0; i < _transactionsList.length; i++) {
      print("${_transactionsList[i].title}: ${_transactionsList[i].date}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          'Flutter App',
          textAlign: TextAlign.center,
        ),
        // actions is where we can put buttons in appBar
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNexTransaction(context),
          ),
          // TESTING
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () {
              _printDateTime();
              for (int i = 0; i < recentTransactionsList.length; i++) {
                print(
                    "recentTransactionsList: ${recentTransactionsList[i].date}");
              }
            },
          )
        ],
      ),
      // the SingleChildScrollView permits to make the body scrollable and to avoid conflict when writing panel pops up
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.black,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ***** CHART ***** //
              Chart(recentTransactionsList),

              // ***** ADD TRANSACTION ***** //
              // i'm getting rid of this to ba able to show it via  showModalBottomSheet()
              // NewTransaction(_addNewTransaction),

              // ***** LIST OF TRANSACTIONS ***** //
              TransactionsList(_transactionsList, _deleteTransaction),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Theme.of(context).primaryColorDark,
        child: Icon(Icons.add),
        onPressed: () => _startAddNexTransaction(context),
      ),
    );
  }
}