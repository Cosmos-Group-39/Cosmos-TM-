class ReviewModel {
  String? id;
  int rating;
  String? description;
  String reviewer;
  String organization;

  ReviewModel({
    this.id,
    required this.rating,
    this.description,
    required this.reviewer,
    required this.organization,
  });
}
