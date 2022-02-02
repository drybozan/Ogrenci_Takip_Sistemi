import 'package:flutter/material.dart';
import 'package:ornek1/models/student.dart';
import 'package:ornek1/validatiors/student_validator.dart';

class StudentAdd extends StatefulWidget {
  List students;

  // StudentAdd(List<Student> students){
  // this.students=students;
  //}
  StudentAdd(this.students); //doğrudan atama sağlar

  @override
  State<StatefulWidget> createState() {
    return _StudentAddState();
  }
}

class _StudentAddState extends State<StudentAdd> with StudentValidationMixin{
  var formKey = GlobalKey<FormState>(); //form durumu için bir anahtar üret,form bilgisini tutar
  var student = Student("", "", 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Yeni Öğrenci Ekle"),
          backgroundColor: Colors.amber,
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
        decoration: const InputDecoration(labelText: "Öğrenci adı"),
    onSaved: (String? value) {
    student.firstName = value!;
    },
    validator: validateFirstName
    );

    }


  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Soyadı"),
      onSaved: (String? value) {
        student.lastName = value!;
      },
      validator:validateLastName,
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Aldığı Not"),
      onSaved: (String? value) {
        student.grade = int.parse(value!);
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
          widget.students.add(student); //student listesine eklenir
          Navigator.pop(context);
          }

        },

      ),
    );
  }
}
