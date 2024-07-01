import 'dart:convert';

import 'package:http/http.dart' as http;

class EquipmentMuscleList {
  Future getEquipmentList() async {
    try {
      var responce = await http.get(
          Uri.parse(
              "https://exercisedb.p.rapidapi.com/exercises/equipmentList"),
          headers: {
            'X-RapidAPI-Key':
                '9fe230bb44msh7cdf525491b44e9p1b0c0cjsnc5e9ebd9ecd1',
            'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
          });
      var jsonData = await jsonDecode(responce.body);
      if (responce.statusCode == 200) {
        return jsonData as List;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //pass the query to the api
  Future getEquipmentMuscleData(String query) async {
    try {
      var responce = await http.get(
          Uri.parse(
              'https://exercisedb.p.rapidapi.com/exercises/equipment/$query'),
          headers: {
            'X-RapidAPI-Key':
                '9fe230bb44msh7cdf525491b44e9p1b0c0cjsnc5e9ebd9ecd1',
            'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
          });

      final jsonData = await jsonDecode(responce.body);

      if (responce.statusCode == 200) {
        return jsonData as List;
      }
    } catch (e) {
      print(e.toString());
    }
  }

}
