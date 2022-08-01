import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/student.dart';
import 'package:provider/provider.dart';

class MarkingHD extends StatefulWidget {
  final String id;
  final Student student;
  final String selectedWeek;
  final String selectedScheme;
  const MarkingHD({Key key, this.id, this.student, this.selectedWeek, this.selectedScheme}) : super(key: key);

  @override
  _MarkingHDState createState() => _MarkingHDState();
}

class _MarkingHDState extends State<MarkingHD> {
  var isChanged = false;
  var selectedGrade = "HD";
  @override
  Widget build(BuildContext context) {
    var student = Provider.of<StudentModel>(context,listen: false).get(widget.id);
    return Scaffold(
      appBar: AppBar(
          title: Text(student.name)
      ),
      body: Center(
        child:
        Row(

          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Text(" ${widget.selectedWeek}"),
            Text(" ${widget.selectedScheme}"),
            DropdownButton<String>(items: ['HD+', 'HD', 'DN', 'CR', 'PP', 'NN'].map((String scheme){
              return DropdownMenuItem<String>(
                value: scheme,
                child: Text(scheme),);
            }).toList(),
              value: selectedGrade,
              onChanged: (String newSelectedGrade){
                setState(() {
                  this.selectedGrade = newSelectedGrade;
                  print(selectedGrade);
                });


              },)


          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        child: Text('submit'),
        onPressed: (){
          if (selectedGrade == "HD+"){
            student.grade[widget.selectedWeek] = 100;
          }
          else if(selectedGrade == "HD"){
            student.grade[widget.selectedWeek] = 80;
          }
          else if(selectedGrade == "DN"){
            student.grade[widget.selectedWeek] = 70;
          }
          else if(selectedGrade == "CR"){
            student.grade[widget.selectedWeek] = 60;
          }
          else if(selectedGrade == "PP"){
            student.grade[widget.selectedWeek] = 50;
          }
          else if(selectedGrade == "NN"){
            student.grade[widget.selectedWeek] = 0;
          }


          Provider.of<StudentModel>(context, listen:false).update(widget.id, student);
          Navigator.pop(context);
        },
      ),
    );
  }
}
