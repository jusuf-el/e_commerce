import 'package:e_commerce/data/models/rating.dart';

class Product {
  int? id;
  String title = '';
  String price = '';
  String category = '';
  String description = '';
  String image = '';
  Rating rating = Rating();

  Product({
    this.id,
    this.title = '',
    this.price = '',
    this.category = '',
    this.description = '',
    this.image = '',
    rating,
  }) : rating = rating ?? Rating();

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    price = json['price'].toString();
    category = json['category'] ?? '';
    description = json['description'] ?? '';
    image = json['image'] ?? '';
    rating = Rating.fromJson(json['rating'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['category'] = category;
    data['description'] = description;
    data['image'] = image;
    data['rating'] = rating;
    return data;
  }

  Product copyWith({
    int? id,
    String? title,
    String? price,
    String? category,
    String? description,
    String? image,
    Rating? rating,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      category: category ?? this.category,
      description: description ?? this.description,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }
}
