import 'package:flutter/material.dart';
import 'subject_page.dart';

class SubjectCard extends StatelessWidget {
  final String subjectName;
  final int subjectId;
  final Color subjectColor;
  final VoidCallback aggiornaPrenotazioni;


  SubjectCard({
    required this.subjectName,
    required this.subjectColor,
    required this.subjectId,
    required this.aggiornaPrenotazioni,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:25.0),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectPage(id: subjectId, nome: subjectName, aggiornaPrenotazioni: aggiornaPrenotazioni),));
          },
            
          child: Container(
            decoration: BoxDecoration(
              color: subjectColor,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            width: 160.0,
            padding: const EdgeInsets.all(12),
            //color: subjectColor ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 150,
                    height: 70,
                    //padding: const EdgeInsets.all(14),
                    //color: Color.fromARGB(68, 255, 255, 255),
                    child: Center(
                      child: Text(subjectName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      
    );
  }
}