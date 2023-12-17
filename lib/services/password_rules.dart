import 'package:string_validator/string_validator.dart';

bool checkPasswordRules(String newPassword) {
  bool result = false;

  if (newPassword.length > 7) {
    for (int i = 0; i < newPassword.length; i++) {
      if (isUppercase(newPassword[i]) && !isInt(newPassword[i])) {
        result = true;
        break;
      }
    }
  }

  return result;
}
