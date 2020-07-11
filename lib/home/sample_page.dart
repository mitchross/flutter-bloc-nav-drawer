import 'package:flutter/material.dart';

import '../navigation/app_drawer.dart';

class SamplePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => SamplePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample Page')),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Sample Page'),
      ),
    );
  }
}
