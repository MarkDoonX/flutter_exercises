import 'package:flutter/material.dart';


import '../widgets/animated_floatingactionbutton.dart';
import '../widgets/test.dart';

class TestScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedFloatingACtionButton1(),
      appBar: AppBar(
        title: Text('Animated FloatingActionButton'),
      ),
      body: Container(),
      // body: PageView(

      //   children: <Widget>[
      //     FabWithIcons(),
      //     AnimatedFloatingACtionButton1(),
      //   ],
      // ),
    );
  }
}
