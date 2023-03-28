import 'package:fetch_api/models/university.dart';
import 'package:http/http.dart'as http;
class RemoteService{
  Future<List<University>?>getWelcome()async
  {
    var client =http.Client();

    var uri =Uri.parse('http://universities.hipolabs.com/search');


    var response =await client.get(uri);
    if(response.statusCode==200){
      var json=response.body;
      return welcomeFromJson(json);
    }
   
  }

  static Future<List<University>>getWelcomeAutocomplete(String query)async
  {
    var client =http.Client();

    var uri =Uri.parse('http://universities.hipolabs.com/search');


    var response =await client.get(uri);
    if(response.statusCode==200){
      var json=response.body;
      return welcomeFromJsonName(json,query);
    }
    else{
      throw Exception();
    }
   
  }
}