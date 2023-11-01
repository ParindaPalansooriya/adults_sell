class Validations{

  bool email(String? value){
    RegExp regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (value!=null && value.isNotEmpty) {
      if (regex.hasMatch(value)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool phone(String? value){
    RegExp regex =  RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');
    if (value!=null && value.isNotEmpty) {
      if (regex.hasMatch(value)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}