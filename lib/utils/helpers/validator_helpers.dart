String? emailValidator(String? value) {
  if (value == null) {
    return 'Enter an email';

}}


String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}
