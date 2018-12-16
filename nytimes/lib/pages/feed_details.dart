import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:nytimes/models/NYTimesModel.dart';

class FeedsDetails extends StatelessWidget
{
  NYTimesModel feedObject;
  FeedsDetails(this.feedObject);

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      routes: {
        "/": (_) => new WebviewScaffold(
          url: this.feedObject.urlString,
          appBar: new AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Feed details'),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),

        ),
      },
    );
  }
}