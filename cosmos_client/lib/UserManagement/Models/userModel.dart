class UserModel {
  String? id;
  String firstName;
  String lastName;
  String email;
  String mobile;
  String password;
  String? address;
  DateTime dob;
  String? profilePic;
  bool isDeleted = false;
  String subcription;
  List<String>? workflows;
  List<String>? organizations;
  List<String>? reviews;
  //Firebase token

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.password,
    this.address,
    required this.dob,
    this.profilePic,
    required this.isDeleted,
    required this.subcription,
    this.workflows,
    this.organizations,
    this.reviews,
  });
}
