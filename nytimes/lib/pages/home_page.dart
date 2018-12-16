import 'package:flutter/material.dart';
import 'package:nytimes/pages/feeds_list.dart';

class home_page extends StatelessWidget {

  void goToFeedsScreen(BuildContext context) {

    Navigator.push(
        context,
      MaterialPageRoute(builder: (context) => ListViewApp()),
    );

    print('button pressed');
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Welcome to NY Times Feeds',
      home: Scaffold(
        appBar: AppBar(
            title: Text('Welcome to NY Times Feeds'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () => goToFeedsScreen(context),
            textColor: Colors.white,
            color: Colors.blue[500],
            padding: const EdgeInsets.all(50.0),
            child: new Text(
              "Go to feeds screen",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}