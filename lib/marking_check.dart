import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/student.dart';
import 'package:provider/provider.dart';

class MarkingCheckBox extends StatefulWidget {
  final String id;
  final Student student;
  final String selectedWeek;
  final String selectedScheme;
  const MarkingCheckBox({Key key, this.id, this.student, this.selectedWeek, this.selectedScheme}) : super(key: key);

  @override
  _MarkingCheckBoxState createState() => _MarkingCheckBoxState();
}

class _MarkingCheckBoxState extends State<MarkingCheckBox> {
  var valuefirst = false;
  var valuesecond = false;
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
              Text(" ${widget.selectedWeek}"),
              Text("${widget.selectedScheme}"),


              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.black,
                    value: valuefirst,
                    onChanged: (bool value) {
                      setState(() {
                        valuefirst = value;
                      });
                    }
                    ),
                   Checkbox(
                     checkColor: Colors.white,
                     activeColor: Colors.black,
                     value: valuesecond,
                     onChanged: (bool value){
                      setState(() {
                         valuesecond = value;
                        });
                        }
                       )






                ],
              ),
            ]


        ),

      ),
      floatingActionButton: FloatingActionButton(
        child: Text('submit'),
        onPressed: (){
          if (valuefirst && valuesecond){
            student.grade[widget.selectedWeek] = 100;
          }
          else if (valuefirst || valuesecond){
            student.grade[widget.selectedWeek] = 50;
          }
          else {
            student.grade[widget.selectedWeek] = 0;
          }



          Provider.of<StudentModel>(context, listen:false).update(widget.id, student);
          Navigator.pop(context);
        },
      ),






    );
  }
}
