import 'dart:ffi';

import 'package:flutter/material.dart';
import 'teaching_card.dart';
import 'model/teaching.dart';


class SubjectPage extends StatefulWidget {
  final int id;
  final String nome;
  final VoidCallback aggiornaPrenotazioni;
  
  const SubjectPage({ Key? key, required this.id, required this.nome, required this.aggiornaPrenotazioni}) : super(key: key);
  

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  /*
  List teaching = [
    [1, 'Simone', 'Multari', 'Giovedi' , 16.00],
    [2, 'Carlo', 'Magno', 'Giovedi' , 16.00],
    [3, 'Carlo', 'Magno', 'Venerdi' , 16.00],
  ];
  */
  
  List teaching = [];

  @override
  void initState() {
    super.initState();
    fetchTeaching();
  }

  Future<void> fetchTeaching() async {
    Teaching.fetchTeaching(widget.id).then((teaching) {
      setState(() {
        this.teaching = teaching;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Seleziona insegnamento'),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Text(
            widget.nome,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:25.0),
              child: RefreshIndicator(
                color: Colors.red,
                displacement: 10.0,
                onRefresh: () => fetchTeaching(),
                child: ListView.builder(
                  itemCount: teaching.length,
                  itemBuilder: (context, index) {
                    return TeachingCard(
                      id: teaching[index].id,
                      nomeDocente: teaching[index].nomeDocente,
                      cognomeDocente: teaching[index].cognomeDocente,
                      giorno: teaching[index].giorno,
                      ora: teaching[index].ora,
                      aggiornaInsegnamenti: fetchTeaching,
                      aggiornaPrenotazioni: widget.aggiornaPrenotazioni,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}