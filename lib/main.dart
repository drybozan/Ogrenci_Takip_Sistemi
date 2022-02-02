import 'package:flutter/material.dart';
import 'package:ornek1/models/student.dart';
import 'package:ornek1/screens/student_add.dart';
import 'package:ornek1/screens/student_update.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State {
  List students = [
    Student.withId(1, "Merve", "Kaya", 85),
    Student.withId(2, "Lale", "Beril", 45),
    Student.withId(3, "Can", "Kızıl", 15)
  ];

  Student selectedStudent = Student.withId(0, " ", "", 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ogrenci Takip Sistemi"),
          backgroundColor: Colors.lightGreen,
        ),
        body: builBody());
  }

  Widget builBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(students[index].firstName +
                        " " +
                        students[index].lastName),
                    subtitle: Text("Sınavdan aldığı not: " +
                        students[index].grade.toString() +
                        " [" +
                        students[index].getStatus +
                        "]"),
                    leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://i.pinimg.com/236x/b0/74/5a/b0745a64be2d9230da8f61438edba5d2.jpg")),
                    trailing: buildStatusIcon(
                        students[index].grade), //ıcon döndrürecek metot yazıldı
                    onTap: () {
                      setState(() {
                        //bu metot ekranın yenilenmesini tetikler.
                        this.selectedStudent = students[
                            index]; //tıklanınca seçili öğrenci bilgileri aktarılır.
                      });
                    });
              }),
        ),
        Text("Seçili öğrenci " +
            selectedStudent.firstName +
            " " +
            selectedStudent.lastName),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.black, // foreground
                ),
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Ekle")
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentAdd(students)))
                      .then((value) => {setState(() {})});
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow, // background
                  onPrimary: Colors.black, // foreground
                ),
                child: Row(
                  children: const [
                    Icon(Icons.update),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text("Güncelle"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentUpdate(selectedStudent)))
                      .then((value) => {setState(() {})});
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.black, // foreground
                ),
                child: Row(
                  children: const [
                    Icon(Icons.delete),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Sil")
                  ],
                ),
                onPressed: () {
                  setState(() {
                    students.remove(
                        selectedStudent); //öğrenciyi sildikten sonra ekranı yeniden çizer
                  });
                  var message = selectedStudent.firstName +
                      " " +
                      selectedStudent.lastName +
                      " başarıyla silindi";
                  showMessage(context, message);
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }

  void showMessage(BuildContext context, String message) {
    var alert = AlertDialog(
      title: Text("İşlem Sonucu"),
      content: Text(message),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
