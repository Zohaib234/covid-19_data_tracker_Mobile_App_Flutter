import 'dart:convert';

import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../../Modal/WorldStateModal.dart';

class StatesServices{
  Future<WorldStateModal> getWorldStateRecord() async {

    final response = await http.get(Uri.parse(AppUrl.WorldStatesApi));
    if(response.statusCode==200){
       var data = jsonDecode(response.body);
       return WorldStateModal.fromJson(data);
    }
    else{
      throw Exception("error occured");
    }

  }

  Future<List<dynamic>> getCountries() async {

    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode==200){
      var  data = jsonDecode(response.body.toString());
      return data;
    }
    else{
      throw Exception("error occured");
    }

  }


}
