class UserModel {
  String id;
  String name;
  String email;
  String password;
  String? address;
  DateTime dob;
  String mobile;
  String? profilePic;
  bool active;

  UserModel(
      {required this.name,
      required this.password,
      required this.email,
      required this.active,
      required this.dob,
      required this.mobile,
      required this.id,
      required this.profilePic,
      required this.address});
}
