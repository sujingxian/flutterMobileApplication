import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';


import 'student.dart';

class StudentDetails extends StatefulWidget
{
  final String id;

  const StudentDetails({Key key, this.id}) : super(key: key);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final studentIDController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    var students = Provider.of<StudentModel>(context, listen:false).items;
    var student = Provider.of<StudentModel>(context,listen: false).get(widget.id);

    var adding = student == null;



    if (!adding) {
      nameController.text = student.name;
      studentIDController.text = student.studentID.toString();

    }

    return Scaffold(
        appBar: AppBar(
          title: Text(adding ? "Add Student" : "Edit Student"),
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if (adding == false) Text("Student Index ${widget.id}"), //check out this dart syntax, lets us do an if as part of an argument list
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: "Name"),
                            controller: nameController,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "studentID"),
                            controller: studentIDController,
                          ),

                          Text('${student.grade}'),




                          ElevatedButton.icon(onPressed: () {
                            if (_formKey.currentState.validate())
                            {
                              if (adding)
                              {
                                student = Student();
                              }

                              //update the student object
                              student.name = nameController.text;
                              student.studentID = int.parse(studentIDController.text); //good code would validate these

                              student.grade = {
                                'week1' : 101,
                                'week2' : 101,
                                'week3' : 101,
                                'week4' : 101,
                                'week5' : 101,
                                'week6' : 101,
                                'week7' : 101,
                                'week8' : 101,
                                'week9' : 101,
                                'week10' : 101,
                                'week11' : 101,
                                'week12' : 101,
                                'week13' : 101,
                              };





                              //TODO: update the model
                              if (adding)
                                Provider.of<StudentModel>(context, listen:false).add(student);
                              else
                                Provider.of<StudentModel>(context, listen:false).update(widget.id, student);




                              //return to previous screen
                              Navigator.pop(context);
                            }
                          }, icon: Icon(Icons.save), label: Text("Save Values")),
                          ElevatedButton.icon(
                              onPressed: () {
                                Share.share(nameController.text,);
                                Share.share(studentIDController.text);
                                Share.share(student.grade.toString());


                          }, icon: Icon(Icons.share), label: Text("Share")),
                          ElevatedButton.icon(
                              onPressed: () {



                              }, icon: Icon(Icons.camera_alt), label: Text("Camera"
                              ))

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

