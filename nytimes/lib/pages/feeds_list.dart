import 'package:flutter/material.dart';
import 'package:nytimes/models/NYTimesModel.dart';
import 'package:nytimes/pages/feed_details.dart';
import 'package:nytimes/services/web_service_manager.dart';
import 'package:progress_hud_v2/progress_hud.dart';



class ListViewApp extends StatefulWidget {
  @override
  FeedsList createState() => new FeedsList();
}

class FeedsList extends State<ListViewApp> {

  final List<NYTimesModel> feedsList = new List();
  ProgressHUD _progressHUD;

  @override
  void initState() {
    super.initState();
    setState(() {

      _progressHUD = new ProgressHUD(
        backgroundColor: Colors.black12,
        color: Colors.white,
        containerColor: Colors.blue,
        borderRadius: 5.0,
        text: 'Loading...',
      );

      WebServiceManager serviceManager = new WebServiceManager();
      serviceManager.fetchNYFeedsFromServer().then((result) {
        setState(() {
          feedsList.clear();
          feedsList.addAll(result);
          _progressHUD.state.dismiss();
        });
      });
    });
  }

  void _onTapItem(BuildContext context, NYTimesModel feedObject) {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedsDetails(feedObject)),
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(

        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('NY Times'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),

          body: new Stack(
            children: <Widget>[
              _progressHUD,
            ListView.builder(
                itemCount: feedsList.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (context, position) {
                  return Column(
                    children: <Widget>[
                      Divider(height: 2.0),
                      ListTile(
                        title:new Container(
                            child:Text(
                              '${feedsList[position].titleString}',
                              style: new TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(0, 5 , 0, 0)
                        ),

                        subtitle:new Container(
                            child:Text(
                              '${feedsList[position].byString}',
                              style: new TextStyle(
                                fontSize: 16.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),

                            //padding: EdgeInsets.all(20.0)
                            padding: EdgeInsets.fromLTRB(0, 10 , 0, 5)
                        ),

                        trailing: Text(
                          '>',
                          style: new TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        leading: Column(
                          children: <Widget>[
                            new Container(
                              child: new CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                radius: 25.0,
                                child: Text(
                                  'No Image',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () => _onTapItem(context, feedsList[position]),
                      ),
                    ],
                  );
                }),
            ],
          )

      ),
    );
  }
}