import 'package:flutter/material.dart';
import 'package:ornek1/models/student.dart';
import 'package:ornek1/validatiors/student_validator.dart';

class StudentUpdate extends StatefulWidget {
  Student selectedStudent;

  // StudentAdd(List<Student> students){
  // this.students=students;
  //}
  StudentUpdate(this.selectedStudent); //doğrudan atama sağlar

  @override
  State<StatefulWidget> createState() {
    return _StudentUpdateState(selectedStudent);
  }
}

class _StudentUpdateState extends State<StudentUpdate> with StudentValidationMixin{
  late Student selectedStudent;
  var formKey = GlobalKey<FormState>(); //form durumu için bir anahtar üret,form bilgisini tutar

  _StudentUpdateState(Student selectedStudent){
    this.selectedStudent = selectedStudent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Öğrenci Güncelle"),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Container(
          margin: EdgeInsets.all(20.00), //tüm kenarlardan boşluk ver
          child: Form(
            key: formKey,
            child: Column(
              children: [
                buildFirstNameField(),
                buildLastNameField(),
                buildGradeField(),
                buildSubmitButton()
              ],
            ),
          ),
        ));
  }

  Widget buildFirstNameField() {
    return TextFormField(
      initialValue: selectedStudent.firstName, //ekran açıldığında default değeri göster
        decoration: const InputDecoration(labelText: "Öğrenci adı"),
        onSaved: (String? value) {
          selectedStudent.firstName = value!;
        },
        validator: validateFirstName
    );

  }


  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudent.lastName,
      decoration: InputDecoration(labelText: "Öğrenci Soyadı"),
      onSaved: (String? value) {
        selectedStudent.lastName = value!;
      },
      validator:validateLastName,
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      initialValue: selectedStudent.grade.toString(),
        decoration: InputDecoration(labelText: "Aldığı Not"),
        onSaved: (String? value) {
          selectedStudent.grade = int.parse(value!);
        },
        validator : validateGrade
    );
  }

  Widget buildSubmitButton() {
    return Container(

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green, // background
          onPrimary: Colors.black, // foreground
        ),
        child: Text("Kaydet"),
        onPressed: () {
          if(formKey.currentState!.validate()){
            formKey.currentState!.save(); //tüm onSavedleri biranda çalıştırır
            Navigator.pop(context);
          }

        },

      ),
    );
  }
}
