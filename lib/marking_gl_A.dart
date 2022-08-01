import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/student.dart';
import 'package:provider/provider.dart';

class MarkingABCD extends StatefulWidget {
  final String id;
  final Student student;
  final String selectedWeek;
  final String selectedScheme;
  const MarkingABCD({Key key, this.id, this.student, this.selectedWeek, this.selectedScheme}) : super(key: key);

  @override
  _MarkingABCDState createState() => _MarkingABCDState();
}

class _MarkingABCDState extends State<MarkingABCD> {
  var isChanged = false;
  var selectedGrade = "A";
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
          DropdownButton<String>(items: ['A', 'B', 'C', 'D', 'F'].map((String scheme){
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
    if (selectedGrade == "A"){
    student.grade[widget.selectedWeek] = 100;
    }
    else if(selectedGrade == "B"){
    student.grade[widget.selectedWeek] = 80;
    }
    else if(selectedGrade == "C"){
      student.grade[widget.selectedWeek] = 70;
    }
    else if(selectedGrade == "D"){
      student.grade[widget.selectedWeek] = 60;
    }
    else if(selectedGrade == "F"){
      student.grade[widget.selectedWeek] = 0;
    }

    Provider.of<StudentModel>(context, listen:false).update(widget.id, student);
    Navigator.pop(context);
    },
    ),
    );

  }
}
