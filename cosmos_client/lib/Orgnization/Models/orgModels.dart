class OrganizationModel {
  String cardID;
  String profilePic;
  String cardName;
  String description;
  List<OrgMembersModel> members;

  OrganizationModel({
    required this.cardID,
    required this.profilePic,
    required this.cardName,
    required this.description,
    required this.members,
  });
}

class OrgMembersModel {
  String memberId;
  String name;
  String role;
  bool isAdmin;

  OrgMembersModel({
    required this.memberId,
    required this.name,
    required this.role,
    this.isAdmin = false, // Default value is false (not an admin)
  });
}
