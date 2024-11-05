class UserApp {
  final String? id;
  final String email;
  final String? password;
  final String? name;
  final String? phoneNumber;
  final String? bloodType;
  final String? image;

  UserApp(
      {this.id,
      this.name,
      required this.email,
      this.password,
      this.phoneNumber,
      this.bloodType,
      this.image});
}
