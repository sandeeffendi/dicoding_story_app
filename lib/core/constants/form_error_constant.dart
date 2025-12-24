class FormErrorConstants {
  static final RegExp emailValidatorRegExp = RegExp(
    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  static final RegExp nameValidatorRegExp = RegExp(r'^[A-Za-z\s]+$');
}
