import 'package:form_field_validator/form_field_validator.dart';

class Validations {
  fnamevalidation() {
    MultiValidator([
      RequiredValidator(errorText: 'First Name is required'),
      MinLengthValidator(3,
          errorText: 'First Name must be at least 3 digits long'),
      PatternValidator(r'^[a-zA-Z]+$',
          errorText: 'passwords must not have special characters')
    ]);
  }

  lnamevalidation() {
    MultiValidator([
      RequiredValidator(errorText: 'Last Name is required'),
      MinLengthValidator(3,
          errorText: 'Last Name must be at least 3 digits long'),
      PatternValidator(r'^[a-zA-Z]+$',
          errorText: 'Last Name must not have special characters')
    ]);
  }

  emailvalidations() {
    MultiValidator([
      RequiredValidator(errorText: 'email is required'),
      EmailValidator(errorText: 'enter a valid email address'),
    ]);
  }

  passwordvalidation() {
    MultiValidator([
      RequiredValidator(errorText: 'Last Name is required'),
      MinLengthValidator(3,
          errorText: 'Last Name must be at least 3 digits long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'passwords must have at least one special character')
    ]);
  }

  phonevalidation() {
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'phone no. must contain onlt numbers');
  }
}
