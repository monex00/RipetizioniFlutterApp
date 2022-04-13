// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'reservation_card.dart';
import 'subject_card.dart';
import 'package:requests/requests.dart';
import 'dart:math';
import 'model/course.dart';
import 'model/reservation.dart';



class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final List colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.purple, Colors.orange, Colors.pink, Colors.cyan, Colors.indigo, Colors.lime, Colors.teal, Colors.amber, Colors.deepPurple, Colors.brown, Colors.grey, Colors.indigoAccent, Colors.redAccent, Colors.greenAccent, Colors.blueAccent, Colors.yellowAccent, Colors.purpleAccent, Colors.orangeAccent, Colors.pinkAccent, Colors.cyanAccent, Colors.indigoAccent, Colors.limeAccent, Colors.tealAccent, Colors.amberAccent, Colors.deepPurpleAccent];
  List<Course> course_list = [];
  List<Reservation> reservation = [];
  
  /*
  List reservation = [
    ['1', ['1','Simone Multari'], ['1', 'Informatica'], 15.0, 1],
    ['3', ['2','Carlo Cracco'], ['1', 'Informatica'], 15.0, 1],
    ['2', ['1','Simone Multari'], ['2', 'Matematica'], 15.0, 1],
  ];
  */

  //final ScrollController _scrollController = ScrollController();
  String lastSubject = "";

  @override
  void initState() {
    super.initState();
    fetchCourses();
    fetchReservation();
  }

  Future<void> fetchCourses() async {
    Course.fetchCourses().then((courses) {
      setState(() {
        course_list = courses;
      });
    });
  }


  Future<void> fetchReservation() async{

    Reservation.fetchReservation().then((reservations) {
      setState(() {
        reservation = reservations;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Benvenuto Utente'),
          
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
        SizedBox(height: 25),

        // list of cards
        Padding(
          padding: EdgeInsets.only(left:25.0),
          child: Text(
            "Seleziona le materie",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26
            ),),
        ),

        SizedBox(height: 25),

        Container(
          height: 200,
          child: RefreshIndicator(
            color: Colors.red,
            displacement: 10.0,
            onRefresh : () => fetchCourses(),
            child: ListView.builder(
              itemCount : (course_list.length/2).round(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index){
                index = index * 2;
                if((course_list.length - index) >= 2){
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SubjectCard(
                          subjectId: course_list[index].id,
                          subjectName: course_list[index].nome,
                          subjectColor: colors[Random().nextInt(colors.length)],
                          aggiornaPrenotazioni: fetchReservation,
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.only(bottom:10.0),
                        child: SubjectCard(
                          subjectId: course_list[index + 1].id,
                          subjectName: course_list[index + 1].nome,
                          subjectColor: colors[Random().nextInt(colors.length)],
                          aggiornaPrenotazioni: fetchReservation,

                        ),
                      ),
                    ],
                  );
              }else{
                return Row(children: [
                  SubjectCard(
                    subjectId: course_list[index].id,
                    subjectName: course_list[index].nome,
                    subjectColor: colors[Random().nextInt(colors.length)],
                    aggiornaPrenotazioni: fetchReservation,
                  ),
                ]);
              }
            },
            ),
          )
        ),

        SizedBox(height: 25),
        // list reservations

         // list of cards
        Padding(
          padding: EdgeInsets.only(left:25.0),
          child: Text(
            "Le tue prenotazioni",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26
            ),),
        ),
        
        SizedBox(height: 25),

        Expanded(
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: RefreshIndicator(
              color: Colors.red,
              displacement: 10.0,
              onRefresh : () => fetchReservation(),
              child: ListView.builder(
                itemCount: reservation.length,
                itemBuilder: (context, index) {
                return Column(
                  children: [
                    changeSubject(index),
                    ReservationCard(
                      id: reservation[index].id,
                      corso: reservation[index].corso.nome,
                      nomeDocente : reservation[index].nomeDocente,
                      cognomeDocente : reservation[index].cognomeDocente,
                      giorno: reservation[index].giorno,
                      ora: reservation[index].oraInizio,
                    ),
                  ],
                );
              },),
            ),
          ) ,)

      ],
              
      ),
    );
  }

  Widget changeSubject(int index){
    if(reservation[index].corso.nome != lastSubject){
      lastSubject = reservation[index].corso.nome;
      return Text(
        lastSubject,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),
      );
    }else{
      return Container();
    }
  }
}