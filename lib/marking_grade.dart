import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/student.dart';
import 'package:provider/provider.dart';

class MarkingGrade extends StatefulWidget {
  final String id;
  final Student student;
  final String selectedWeek;
  final String selectedScheme;



  const MarkingGrade({Key key, this.id, this.selectedWeek, this.selectedScheme, this.student, }) : super(key: key);

  @override
  _MarkingGradeState createState() => _MarkingGradeState();
}

class _MarkingGradeState extends State<MarkingGrade> {
  var valuefirst = false;
  @override

  Widget build(BuildContext context) {
    var student = Provider.of<StudentModel>(context,listen: false).get(widget.id);


    return Scaffold(
      appBar: AppBar(
        title: Text(student.name)
      ),
      body: Center(
        child:
        Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("selected week ${widget.selectedWeek}"),
            Text("selected scheme ${widget.selectedScheme}"),


            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                    activeColor: Colors.black,
                    value: valuefirst,
                    onChanged: (bool value){
                    setState(() {
                      valuefirst = value;
                    });



                    print(valuefirst);
                    },
                    ),
              ],
            ),
          ]


        ),

      ),
      floatingActionButton: FloatingActionButton(
        child: Text('submit'),
        onPressed: (){
          if (valuefirst){
            student.grade[widget.selectedWeek] = 100;
          }
          else{
            student.grade[widget.selectedWeek] = 0;
          }


          Provider.of<StudentModel>(context, listen:false).update(widget.id, student);
          Navigator.pop(context);
        },
      ),






    );



  }
}
