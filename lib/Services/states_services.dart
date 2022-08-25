import 'dart:convert';

import 'package:coronavirusindicatorproject/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;
import '../Model/world_states_model.dart';
class WorldsStatesFetch{
  Future<WorldStatesModel> fetchWorldStates()async{
    
  final response = await http.get(Uri.parse(ApiUrl.worldstateUrl));
      
  if (response.statusCode == 200) {
    return WorldStatesModel.fromJson(jsonDecode(response.body));
  }
  else{
    return throw Exception("Error");
  }
    
 }
 Future<List<dynamic>> fetchCountriesStates()async{
    var data;
  final response = await http.get(Uri.parse(ApiUrl.countriesList));
      
  if (response.statusCode == 200) {
     data =  jsonDecode(response.body);
    // print(data);
    return data;
  }
  else{
    return throw Exception("Error");
  }
    
 }
 }