import 'package:flutter/material.dart';
import 'model/teaching.dart';

class TeachingCard extends StatelessWidget {
  final int id;
  final String nomeDocente;
  final String cognomeDocente;
  final String giorno;
  final double ora;
  final VoidCallback aggiornaInsegnamenti;
  final VoidCallback aggiornaPrenotazioni;

  TeachingCard({
    required this.id,
    required this.nomeDocente,
    required this.cognomeDocente,
    required this.giorno,
    required this.ora,
    required this.aggiornaInsegnamenti,
    required this.aggiornaPrenotazioni
    });

  Future<bool> prenota(int id) async{
    if(await Teaching.prenota(id)){
      aggiornaInsegnamenti();
      aggiornaPrenotazioni();
      return true;
    }
    return false;
  }  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        //padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
          ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              margin: EdgeInsets.only(left: 15.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(nomeDocente + " " + cognomeDocente,
                      textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ),
                ),
                Text(giorno + " " + ora.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20),
              ),
              ],),
            ),
            
             Container(
               margin: EdgeInsets.only(right: 15.0),
               child: ElevatedButton.icon(
                 style: ElevatedButton.styleFrom(
                   primary: Colors.green),
                 onPressed: () {
                  prenota(id);
                 }, 
                 icon: Icon(Icons.add),
                 label: Text("Prenota"),
                ),
             ),
          ],
        )
      ),
    );
  }
}