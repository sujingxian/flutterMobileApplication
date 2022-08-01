import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/Camera.dart';
import 'package:flutter_tutorial_3/marking_student.dart';
import 'package:flutter_tutorial_3/student_details.kt.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';

import 'student.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //added this line
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) //this functio is called every time the "future" updates
      {
        // Check for errors
        if (snapshot.hasError) {
          return FullScreenText(text:"Something went wrong");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done)
        {
          //BEGIN: the old MyApp builder from last week
          return ChangeNotifierProvider(
            create: (context) => StudentModel(),
            child: MaterialApp(
                home: DefaultTabController(
                  length:  3,
                  child: Scaffold(
                    appBar: AppBar(
                      bottom: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.article_outlined)),
                          Tab(icon: Icon(Icons.account_box_rounded)),
                          Tab(icon: Icon(Icons.add_chart)),
                        ],
                      ),
                      title: Text('Marking System'),
                    ),
                    body:TabBarView(
                      children: [
                        CameraPage(),
                        StudentListPage(),
                        MarkListPage(),
                      ],
                    ),


                  ),

                )



            ),
          );
          //END: the old MyApp builder from last week
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return FullScreenText(text:"Loading");
      },
    );
    //BEGIN: the old MyApp builder from last week

    //END: the old MyApp builder from last week
  }
}

class StudentListPage extends StatefulWidget
{


  @override
  _StudentListPageState createState() => _StudentListPageState();
}


class _StudentListPageState extends State<StudentListPage>
{
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentModel>(
        builder:buildScaffold
    );
  }

  Scaffold buildScaffold(BuildContext context, StudentModel studentModel, _) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //Add page
          showDialog(context: context, builder: (context) {
            return StudentDetails();
          });


        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            //YOUR UI HERE
            if (studentModel.loading) CircularProgressIndicator() else Expanded(
              child: ListView.builder(
                  itemBuilder: (_, index) {
                    var student = studentModel.items[index];
                    return Dismissible(
                      child: ListTile(
                        title: Text(student.name),
                        subtitle: Text(student.studentID.toString() ),


                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return StudentDetails(id: student.id);
                              }));
                        },
                      ),
                      background: Container(color: Colors.redAccent,),
                      key: ValueKey<String>(student.id),
                      onDismissed: (DismissDirection direction){
                        setState(() {
                          studentModel.items.removeAt(index);
                        });
                        studentModel.delete(student.id);
                      },
                    );
                  },
                  itemCount: studentModel.items.length
              ),
            )
          ],
        ),
      ),
    );
  }
}

//A little helper widget to avoid runtime errors -- we can't just display a Text() by itself if not inside a MaterialApp, so this workaround does the job
class FullScreenText extends StatelessWidget {
  final String text;

  const FullScreenText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection:TextDirection.ltr, child: Column(children: [ Expanded(child: Center(child: Text(text))) ]));
  }
}

class MarkListPage extends StatefulWidget{

  @override
  _MarkListPageState createState() => _MarkListPageState();
}

class _MarkListPageState extends State<MarkListPage>{

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentModel>(
        builder:buildScaffold
    );
  }

  Scaffold buildScaffold(BuildContext context, StudentModel studentModel, _) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mark List"),
      ),


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            //YOUR UI HERE
            if (studentModel.loading) CircularProgressIndicator() else Expanded(
              child: ListView.builder(
                  itemBuilder: (_, index) {
                    var student = studentModel.items[index];
                    return ListTile(

                        title: Text(student.name),
                        subtitle: Text(student.studentID.toString() ),


                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return MarkingScheme(id: student.id,);
                              }));
                        },
                      );


                  },
                  itemCount: studentModel.items.length
              ),
            )
          ],
        ),
      ),
    );
  }
}


