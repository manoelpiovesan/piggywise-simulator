import 'package:flutter/cupertino.dart';

///
///
///
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

///
///
///
class _HomeState extends State<Home> {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Piggywise Simulator'),
        ),
        child: SafeArea(
            child: Column(
          children: const <Widget>[
            Text('Piggywise Simulator'),
          ],
        )));
  }
}
