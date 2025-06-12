class RegisterRequestModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;
  final String university;
  final String faculty;
  final String? image;

  RegisterRequestModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.university,
    required this.faculty,
    this.image,
  });
}
