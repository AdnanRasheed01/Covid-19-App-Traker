import 'dart:convert';


import 'package:covidapp/model/world_state.dart';
import 'package:covidapp/services/utalities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices{
  Future<WorldStatesModel>fetchWorldSatesRecords() async{


    final response = await http.get(Uri.parse(Appurl.worldStatesApi));

    if (response.statusCode==200)
    {
      var data= jsonDecode(response.body);

      return WorldStatesModel.fromJson(data);


    }else{
      throw Exception('Erroe');



    }
  }
  Future<List<dynamic>>CountrieslistApi() async{


    final response = await http.get(Uri.parse(Appurl.countriesList));
  var data;
    if (response.statusCode==200)
    {
      var data= jsonDecode(response.body);

      return data;


    }else{
      throw Exception('Erroe');



    }
  }





}