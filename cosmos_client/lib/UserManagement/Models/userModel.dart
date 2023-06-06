class UserModel {
  String name;
  String email;
  String password;
  String? address;
  DateTime? dob;
  String mobile;
  String? profilePic;
  bool active;

  UserModel(
      {required this.name,
      required this.password,
      required this.email,
      required this.active,
      required this.mobile});
}
