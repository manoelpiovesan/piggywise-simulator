import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_simulator/views/home.dart';

///
///
///
void main() {
  runApp(const PiggySimulator());
}

///
///
///
class PiggySimulator extends StatelessWidget {
  ///
  ///
  ///
  const PiggySimulator({super.key});

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Piggywise Simulator',
      theme: CupertinoThemeData(
        primaryColor: Colors.blue,
      ),
      home: Home(),
    );
  }
}
