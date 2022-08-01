import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/student.dart';
import 'package:provider/provider.dart';

class MarkingScore extends StatefulWidget {
  final String id;
  final Student student;
  final String selectedWeek;
  final String selectedScheme;
  const MarkingScore({Key key, this.id, this.student, this.selectedWeek, this.selectedScheme}) : super(key: key);

  @override
  _MarkingScoreState createState() => _MarkingScoreState();
}

class _MarkingScoreState extends State<MarkingScore> {
  final _formKey = GlobalKey<FormState>();
  final scoreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var student = Provider.of<StudentModel>(context, listen:false).get(widget.id);
    scoreController.text = student.grade[[widget.selectedWeek]].toString();
    return Scaffold(
        appBar: AppBar(
          title: Text("${student.name}"),
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[ //check out this dart syntax, lets us do an if as part of an argument list
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: "Grade"),
                            controller: scoreController,
                          ),

                          ElevatedButton.icon(onPressed: () {
                            if (_formKey.currentState.validate())
                            {

                              //update the student object
                              student.grade[widget.selectedWeek] = int.parse(scoreController.text);



                              //TODO: update the model
                                Provider.of<StudentModel>(context, listen:false).update(widget.id, student);




                              //return to previous screen
                              Navigator.pop(context);
                            }
                          }, icon: Icon(Icons.save), label: Text("Save Values"))
                        ],
                      ),
                    ),
                  ),

                ]
            )
        )
    );
  }
}
