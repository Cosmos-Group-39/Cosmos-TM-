import 'package:cosmos_client/Orgnization/Models/orgModels.dart';

class FeedbackModel {
  String reviewerID;
  String rating;
  String description;
  List<OrganizationModel> oid;

  FeedbackModel({
    required this.reviewerID,
    required this.rating,
    required this.description,
    required this.oid,
  });
}
