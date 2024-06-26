class ForgotPasswordModelRep {
  final int status;
  final String message;
  final String password;

  const ForgotPasswordModelRep({
    required this.status,
    required this.message,
    required this.password,
  });
}