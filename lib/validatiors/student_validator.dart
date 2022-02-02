class StudentValidationMixin{
     String? message ;


  String? validateFirstName(String? value){
    if(value!.length < 2){
      message = "İsim en az 2 karekter olmalıdır.";
    }
    return message;
  }

  String? validateLastName(String? value){
    if(value!.length < 2){
      message = "Soyisim en az 2 karekter olmalıdır.";
    }
    return message;
  }

  String? validateGrade(String? value){
    var grade = int.parse(value!);
    if(grade < 0){
      message = " Not 0-100 aralığında olmalıdır.";
    }
    return message;
  }
}