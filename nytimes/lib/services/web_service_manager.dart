  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:nytimes/models/NYTimesModel.dart';

  class WebServiceManager
  {

    Future<List<NYTimesModel>> fetchNYFeedsFromServer() async {

      try
      {
        final response = await http.get('http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?apikey=2881951549db402ba4b8b41520774ffc');

        List responseJson = json.decode(response.body)["results"];

        List<NYTimesModel> feeds = createFeedsList(responseJson);

        return feeds;
      }
      catch(exception)
      {
        print('Execption occured in fetchNYFeedsFromServer $exception');
        //return new List<NYTimesModel>();
      }
    }

    List<NYTimesModel> createFeedsList(List data){

      try
      {
        List<NYTimesModel> feeds = new List();

        for (int i = 0; i < data.length; i++) {

          String urlString = data[i]["url"];
          String titleString = data[i]["title"];
          String byString = data[i]["byline"];
          String sourceString = data[i]["source"];
          String dateString = data[i]["published_date"];

          NYTimesModel nytimesObject = new NYTimesModel(titleString, byString, sourceString, dateString, urlString);
          feeds.add(nytimesObject);
          nytimesObject=null;
        }

        return feeds;
      }
      catch(exception)
      {
        print('Execption occured in fetchNYFeedsFromServer $exception');
        return new List<NYTimesModel>();
      }
    }
  }