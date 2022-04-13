import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

class Teaching{
  int id;
  String nomeDocente;
  String cognomeDocente;
  String giorno;
  double ora;

  Teaching(this.id, this.nomeDocente, this.cognomeDocente, this.giorno, this.ora);

  static Future<List<Teaching>> fetchTeaching(int idCorso) async{
    String url = 'http://10.0.2.2:8080/Prenotazioni0_war_exploded';
    List<Teaching> teachings = [];
  
    //fetching courses
    final response = await Requests.post(url + '/getData', body: {
      "operation": "getTeachingByCourse",
      "id": idCorso,
    });

    //TODO:check response status
    dynamic data = response.json();
    for(int i=0; i<data['insegnamenti'].length; i++){

      String nomeDocente = data['insegnamenti'][i]['docente']['nome'];
      String cognomeDocente = data['insegnamenti'][i]['docente']['cognome'];
      
      for(int j=0; j<data['insegnamenti'][i]['insegnamenti'].length; j++){
        int id = data['insegnamenti'][i]['insegnamenti'][j]['id'];
        int giorno = data['insegnamenti'][i]['insegnamenti'][j]['giorno'];
        double ora = data['insegnamenti'][i]['insegnamenti'][j]['ora'];
        teachings.add(Teaching(id, nomeDocente, cognomeDocente, getDayByNumber(giorno), ora));
      }
      
    }
    return teachings;
  }

  static Future<bool> prenota(int idInsegnamento) async{
    String url = 'http://10.0.2.2:8080/Prenotazioni0_war_exploded';
    
    //fetching courses
    final response = await Requests.post(url + '/operations', body: {
      "entity": "reservation",
      "operation": "personalOperation",
      "idInsegnamento": idInsegnamento,
    });

    dynamic data = response.json();
    if(data['status'] == 'ok'){
      return true;
    }
    else{
      return false;
    }
  }

   static String getDayByNumber(int day){
    switch(day){
      case 1:
        return "Lunedi";
      case 2:
        return "Martedi";
      case 3:
        return "Mercoledi";
      case 4:
        return "Giovedi";
      case 5:
        return "Venerdi";
      default:
        return "";
    }
  }
}