class LoginRequest {
  final String email;
  final String password;
  final String imei;
  final String deviceName;

  const LoginRequest({
    required this.email,
    required this.password,
    required this.imei,
    required this.deviceName,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'imei': imei,
      'deviceName': deviceName,
    };
  }
}

