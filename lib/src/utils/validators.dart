class Validators {
  static String required(String value) =>
      value.isNotEmpty ? null : 'This field must not be Empty';

  static String email(String value) {
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value)) {
      return 'Please provide a valid email';
    }
    return null;
  }

  static String requiredEmail(String value) {
    return multiple([required, email])(value);
  }

  static String requiredPassword(String value) {
    return value.isEmpty
        ? 'Please provide password'
        : (value.length < 8)
            ? 'Password must be at least 8 characters'
            : null;
  }

  static String Function(String) multiple(
      List<String Function(String)> validators) {
    return (String value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }

      return null;
    };
  }
}
