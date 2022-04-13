import 'dart:ffi';

import 'package:flutter/material.dart';
import 'homepage.dart';


class ReservationCard extends StatelessWidget {
  final int id;
  final String corso;
  final String nomeDocente;
  final String cognomeDocente;
  final String giorno;
  final double ora;

  ReservationCard({
    required this.id,
    required this.corso, 
    required this.nomeDocente,
    required this.cognomeDocente,
    required this.giorno,
    required this.ora
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
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
              //padding: EdgeInsets.all(15.0),
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
            
             Column(
              children: [
                ElevatedButton(
                  onPressed: () {}, 
                  child: Icon(Icons.check, color: Colors.white),
                  // ignore: prefer_const_constructors
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    
                    shape: CircleBorder(),
                  ),
                  ),
                ElevatedButton(
                  onPressed: () {}, 
                  child: Icon(Icons.delete, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    
                    shape: CircleBorder(),
                  ),
                  ),
              ],
            ),
          ],
        )
      ),
    );
  }
}