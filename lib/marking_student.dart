import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/marking_check.dart';
import 'package:flutter_tutorial_3/marking_gl_A.dart';
import 'package:flutter_tutorial_3/student.dart';
import 'package:provider/provider.dart';

import 'marking_gl_HD.dart';
import 'marking_grade.dart';
import 'marking_score.dart';

class MarkingScheme extends StatefulWidget {
  final String id;

  const MarkingScheme({Key key, this.id,}) : super(key: key);




  @override
  _MarkingSchemeState createState() => _MarkingSchemeState();
}

class _MarkingSchemeState extends State<MarkingScheme> {
  var selectedWeek = 'week1';
  var selectedScheme = 'Attendance';
  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    var student = Provider.of<StudentModel>(context,listen: false).get(widget.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name,
          style: TextStyle(fontSize: 30.0),
        ),
        backgroundColor: Colors.blue,

      ),




      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
            children:[
              Text('Select week'),
              DropdownButton<String>(items: ['week1', 'week2', 'week3', 'week4', 'week5','week6','week7','week8','week9','week10','week11','week12', 'week13'].map((String week){
                return DropdownMenuItem<String>(
                    value: week,
                    child: Text(week),);
              }).toList(),
                  value: selectedWeek,
              onChanged: (String newSelectedWeek){
                setState(() {
                  this.selectedWeek = newSelectedWeek;
                  print(selectedWeek);
                });

              },)
            ],
            ),
            Row(
              children: [
                Text('Select marking Scheme'),
                DropdownButton<String>(items: ['Attendance', 'CheckBox', 'GradeLevel(A,B,C,D)', 'GradeLevel(HD,DN,CR,PP,NN)', 'Score'].map((String scheme){
                  return DropdownMenuItem<String>(
                    value: scheme,
                    child: Text(scheme),);
                }).toList(),
                  value: selectedScheme,
                  onChanged: (String newSelectedScheme){
                    setState(() {
                      this.selectedScheme = newSelectedScheme;
                      print(selectedScheme);
                    });

                  },)
              ],

            ),
            Text('Grade: ${student.grade[selectedWeek]}')





          ],



        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){


          //Add page
          Navigator.push(context, MaterialPageRoute(builder: (context){

            if (selectedScheme == "Attendance") {
              return MarkingGrade(id: student.id,
                selectedScheme: selectedScheme,
                selectedWeek: selectedWeek,);
            }
            else if(selectedScheme == "GradeLevel(A,B,C,D)"){
              return MarkingABCD(id: student.id,
                selectedScheme: selectedScheme,
                selectedWeek: selectedWeek,);
            }
            else if(selectedScheme == "GradeLevel(HD,DN,CR,PP,NN)"){
              return MarkingHD(id: student.id,
                selectedScheme: selectedScheme,
                selectedWeek: selectedWeek,);
            }
            else if(selectedScheme == "CheckBox"){
              return MarkingCheckBox(id: student.id,
                selectedScheme: selectedScheme,
                selectedWeek: selectedWeek,);
            }
            else if(selectedScheme == "Score"){
              return MarkingScore(id: student.id,
                selectedScheme: selectedScheme,
                selectedWeek: selectedWeek,);
            }
          }));


        },
        child: const Icon(Icons.wysiwyg_rounded),
        backgroundColor: Colors.green,),



    );



  }
}
