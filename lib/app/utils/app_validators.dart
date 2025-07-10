

class Validators {
  /// Checks if the field is not empty or null.
  static String? required(String? value, {String field = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  /// Validates an email address using a standard regex pattern.
  static String? email(String? value, {String field = 'Email'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
      r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
      r"(?:\.[a-zA-Z]{2,})+$",
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  /// Validates password strength (min 8 chars, upper/lowercase, number, special char).
  static String? password(String? value, {String field = 'Password'}) {
    if (value == null || value.isEmpty) {
      return '$field is required';
    }

    if (value.length < 8) {
      return '$field must be at least 8 characters';
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      return '$field must include at least one number';
    }

    return null;
  }

  /// Checks if value meets a minimum length.
  static String? minLength(
    String? value,
    int length, {
    String field = 'Field',
  }) {
    if (value == null || value.length < length) {
      return '$field must be at least $length characters';
    }
    return null;
  }

  /// Checks if value meets a maximum length.
  static String? maxLength(
    String? value,
    int length, {
    String field = 'Field',
  }) {
    if (value != null && value.length > length) {
      return '$field must be at most $length characters';
    }
    return null;
  }

  /// Compares two values for equality (e.g., password confirmation).
  static String? mustMatch(
    String? value,
    String? otherValue, {
    String field = 'Field',
  }) {
    if (value != otherValue) {
      return '$field does not match';
    }
    return null;
  }
}
