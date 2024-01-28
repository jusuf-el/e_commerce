class Rating {
  double rate = 0.0;
  int count = 0;

  Rating({
    this.rate = 0.0,
    this.count = 0,
  });

  Rating.fromJson(Map<String, dynamic> json) {
    rate = (json['rate'] ?? 0.0).toDouble();
    count = json['count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
}
