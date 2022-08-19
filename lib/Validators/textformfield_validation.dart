class TextFieldValidation {
  static String? userIDValidation(String? studentID) {
    if (studentID == null || studentID.isEmpty) {
      return "Required";
    }
    // else if (studentID.length < 6) {
    //   return "Enter valid ID";
    // }
    else {
      return null;
    }
  }
  static String? userMobileValidation(String? mobileNo) {
    if (mobileNo == null || mobileNo.isEmpty) {
      return "Required";
    } else if (mobileNo.length < 10) {
      return "Enter valid MobileNo";
    } else {
      return null;
    }
  }
  static String? passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return "Required";
    } else if (password.length < 6) {
      return "Password must be at least 6 characters";
    } else if (password.length >= 16) {
      return "Your password is too long";
    } else {
      return null;
    }
  }

  static String? schoolIDValidation(String schoolID) {
    if (schoolID == null || schoolID.isEmpty) {
      return "Required";
    } else if (schoolID.length < 6) {
      return "Enter valid ID";
    } else {
      return null;
    }
  }
}
