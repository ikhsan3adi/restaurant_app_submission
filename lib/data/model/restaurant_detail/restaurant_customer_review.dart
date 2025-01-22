class RestaurantCustomerReview {
  final String name;
  final String review;
  final String date;

  const RestaurantCustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory RestaurantCustomerReview.fromJson(Map<String, dynamic> json) {
    return RestaurantCustomerReview(
      name: json['name'],
      review: json['review'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'review': review,
        'date': date,
      };
}
