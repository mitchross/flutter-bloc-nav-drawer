import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => TestPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      body: Center(
        child: Text('Test Page'),
      ),
    );
  }
}
