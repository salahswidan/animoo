class AppVaildators {
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This name cannot be empty";
    } else if (value.length < 3) {
      return "Name must be at least 3 characters long";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$',
    );
    if (!passwordRegex.hasMatch(value)) {
      return "Password must contain at least one uppercase letter, one lowercase letter, and one number";
    }
    return null;
  }
  static String? confirmPasswordValidator(String? valuePassword,String ? valueConfirmPassword) {
    if (valuePassword == null || valuePassword.isEmpty) {
      return "Confirm Password cannot be empty";
    }
    if (valuePassword != valueConfirmPassword) {
      return "Passwords do not match";
    }
    return null;
  }
}
