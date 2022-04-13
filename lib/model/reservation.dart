import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'course.dart';

class Reservation{
  int id;
  String nomeDocente;
  String cognomeDocente;
  Course corso;
  String giorno;
  double oraInizio;


  Reservation(this.id, this.nomeDocente, this.cognomeDocente, this.corso, this.giorno, this.oraInizio);

  static Future<List<Reservation>> fetchReservation() async{
    String url = 'http://10.0.2.2:8080/Prenotazioni0_war_exploded';
    List<Reservation> reservations = [];
  
    //fetching courses
    final response = await Requests.post(url + '/getData', body: {
      "operation": "getMyReservations"
    });

    //TODO:check response status
    dynamic data = response.json();
   
    
    
    for(int i=0;i<data.length;i++){
      String nomeDocente = data[i]['insegnamento']['docente']['nome'];
      String cognomeDocente = data[i]['insegnamento']['docente']['cognome'];
      Course corso = Course(data[i]['insegnamento']['corso']['id'], data[i]['insegnamento']['corso']['nome']);
      String giorno = getDayByNumber(data[i]['insegnamento']['giorno']);
      double oraInizio = data[i]['insegnamento']['ora'];
  
      reservations.add(Reservation(data[i]['id'], nomeDocente, cognomeDocente, corso, giorno, oraInizio));
    }
    
    return reservations;
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