import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Student
{
  String name;
  int studentID;
  Map grade;
  String image;


  String id;


  Student({this.name, this.studentID,this.image, this.grade, });

  Student.fromJson(Map<String, dynamic> json)
      :
        name = json['name'],
        image=json['image'],
        grade=json['grade'],
        studentID = json['studentID'];



  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'studentID': studentID,
        'image': image,
        'grade': grade,

      };
}

class StudentModel extends ChangeNotifier {

  Student get(String id)
  {
    if (id == null) return null;
    return items.firstWhere((student) => student.id == id);
  }

  /// Internal, private state of the list.
  final List<Student> items = [];

  CollectionReference studentsCollection = FirebaseFirestore.instance.collection('students');
  bool loading = false;

  //Normally a model would get from a database here, we are just hardcoding some data for this week
  StudentModel()
  {
    fetch();
  }

  void add(Student item) async
  {
    loading = true;
    notifyListeners();

    await studentsCollection.add(item.toJson());

    //refresh the db
    await fetch();
  }

  void update(String id, Student item) async
  {
    loading = true;
    notifyListeners();

    await studentsCollection.doc(id).set(item.toJson());

    //refresh the db
    await fetch();
  }

  void fetch() async
  {
    //clear any existing data we have gotten previously, to avoid duplicate data
    items.clear();

    //indicate that we are loading
    loading = true;
    notifyListeners(); //tell children to redraw, and they will see that the loading indicator is on

    //get all students
    var querySnapshot = await studentsCollection.orderBy("name").get();

    //iterate over the movies and add them to the list
    querySnapshot.docs.forEach((doc) {

      var student = Student.fromJson(doc.data());
      student.id = doc.id;
      items.add(student);
    });

    //put this line in to artificially increase the load time, so we can see the loading indicator (when we add it in a few steps time)
    //comment this out when the delay becomes annoying

    //we're done, no longer loading
    loading = false;
    notifyListeners();
  }

  void delete(String id) async
  {
    loading = true;
    notifyListeners();

    await studentsCollection.doc(id).delete();

    //refresh the db
    await fetch();
  }

}