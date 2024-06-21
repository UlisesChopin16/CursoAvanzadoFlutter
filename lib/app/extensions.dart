const empty = '';
const zero = 0;

// extension on String
extension NonNullString on String? {

  /// This extension is used to return an empty string if the value is null
  String orEmpty() {
    /// if the value is null, return an empty string
    return this ?? empty;
  }
}

// extension on Integer
extension NonNullInt on int? {
  /// This extension is used to return 0 if the value is null
  int orZero() {
    return this ?? zero;
  }
}