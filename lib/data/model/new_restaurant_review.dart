class NewRestaurantReview {
  final String id;
  final String name;
  final String review;

  const NewRestaurantReview({
    required this.id,
    required this.name,
    required this.review,
  });

  factory NewRestaurantReview.fromJson(Map<String, dynamic> json) {
    return NewRestaurantReview(
      id: json['id'],
      name: json['name'],
      review: json['review'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'review': review,
      };
}
