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
  String? email;

  OrgMembersModel({
    required this.isAdmin,
    required this.userId,
    this.email,
  });

  factory OrgMembersModel.fromJson(Map<String, dynamic> json) {
    return OrgMembersModel(isAdmin: json['isAdmin'] as bool, userId: json['_id'], email: json['email']);
  }
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

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
        id: json['_id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        pic: json['pic'] ?? '',
        reviews: List<String>.from(json['reviews']),
        workflows: List<String>.from(json['workflows']),
        members: List<OrgMembersModel>.from(json['members'].map((e) => OrgMembersModel.fromJson(e)).toList()),
        labels: List<String>.from(json['labels']));
  }
}
