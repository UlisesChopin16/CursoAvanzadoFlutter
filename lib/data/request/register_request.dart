class RegisterRequest {
  final String countryMobileCode;
  final String userName;
  final String email;
  final String password;
  final String mobileNumber;
  final String profilePicture;

  const RegisterRequest({
    required this.countryMobileCode,
    required this.userName,
    required this.email,
    required this.password,
    required this.mobileNumber,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'country_mobile_code': countryMobileCode,
      'user_name': userName,
      'email': email,
      'password': password,
      'mobile_number': mobileNumber,
      'profile_picture': profilePicture,
    };
  }
}