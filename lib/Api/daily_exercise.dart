// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class DailyExerciseApi {
  Future getDailyExercise() async {
    try {
      final responce = await http.get(
          Uri.parse("https://exercisedb.p.rapidapi.com/exercises"),
          headers: {
            'X-RapidAPI-Key':
                '9fe230bb44msh7cdf525491b44e9p1b0c0cjsnc5e9ebd9ecd1',
            'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
          });
      final jsonData = jsonDecode(responce.body);
      // final instruction = jsonData['instructions'] as List;
      print(jsonData[0]['gifUrl']);
      if(responce.statusCode == 200){
        return jsonData as List;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Search exercise

  Future getSearchName(String name)async{
    try {
      final responce = await http.get(
          Uri.parse("https://exercisedb.p.rapidapi.com/exercises/name/$name"),
          headers: {
            'X-RapidAPI-Key':
                '9fe230bb44msh7cdf525491b44e9p1b0c0cjsnc5e9ebd9ecd1',
            'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
          });
      final jsonData = jsonDecode(responce.body);
      // final instruction = jsonData['instructions'] as List;
      // print(jsonData[0]['gifUrl']);
      if(responce.statusCode == 200){
        return jsonData as List;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
