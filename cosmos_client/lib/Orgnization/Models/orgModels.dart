// class OrganizationModel {
//   String cardID;
//   String profilePic;
//   String cardName;
//   String description;
//   List<OrgMembersModel> members;

//   OrganizationModel({
//     required this.cardID,
//     required this.profilePic,
//     required this.cardName,
//     required this.description,
//     required this.members,
//   });
// }

// class OrgMembersModel {
//   String memberId;
//   String name;
//   String role;
//   bool isAdmin;

//   OrgMembersModel({
//     required this.memberId,
//     required this.name,
//     required this.role,
//     this.isAdmin = false, // Default value is false (not an admin)
//   });
// }

class OrgMembersModel {
  bool isAdmin = false;
  String userId;
  String name;

  OrgMembersModel({
    required this.isAdmin,
    required this.userId,
    required this.name,
  });
}

class OrganizationModel {
  String? id;
  String name;
  String description;
  String? pic;
  List<String>? reviews;
  List<String>? workflows;
  List<OrgMembersModel>? members;
  List<String>? labels;

  OrganizationModel({
    this.id,
    required this.name,
    required this.description,
    this.pic,
    this.reviews,
    this.workflows,
    this.members,
    this.labels,
  });
}
