// models/product_model.dart

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String>? tags; // Nullable field
  final String brand;
  final String sku;
  final double weight;
  final String returnPolicy;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review>? reviews; // Nullable field
  final Meta meta;
  final List<String>? images; // Nullable field
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    this.tags, // Nullable field
    required this.brand,
    required this.sku,
    required this.weight,
    required this.returnPolicy,
    required this.shippingInformation,
    required this.availabilityStatus,
    this.reviews, // Nullable field
    required this.meta,
    this.images, // Nullable field
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0, // Default to 0 if null
      title: json['title'] ?? '', // Default to empty string if null
      description: json['description'] ?? '', // Default to empty string if null
      category: json['category'] ?? '', // Default to empty string if null
      price: json['price']?.toDouble() ?? 0.0, // Default to 0.0 if null
      discountPercentage: json['discountPercentage']?.toDouble() ?? 0.0, // Default to 0.0 if null
      rating: json['rating']?.toDouble() ?? 0.0, // Default to 0.0 if null
      stock: json['stock'] ?? 0, // Default to 0 if null
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      brand: json['brand'] ?? '', // Default to empty string if null
      sku: json['sku'] ?? '', // Default to empty string if null
      weight: json['weight']?.toDouble() ?? 0.0, // Default to 0.0 if null
      returnPolicy: json['returnPolicy'] ?? '', // Default to empty string if null
      shippingInformation: json['shippingInformation'] ?? '', // Default to empty string if null
      availabilityStatus: json['availabilityStatus'] ?? '', // Default to empty string if null
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((review) => Review.fromJson(review)).toList()
          : null,
      meta: Meta.fromJson(json['meta'] ?? {}),
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      thumbnail: json['thumbnail'] ?? '', // Default to empty string if null
    );
  }
}

class Review {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      date: json['date'] ?? '',
      reviewerName: json['reviewerName'] ?? '',
      reviewerEmail: json['reviewerEmail'] ?? '',
    );
  }
}

class Meta {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      barcode: json['barcode'] ?? '',
      qrCode: json['qrCode'] ?? '',
    );
  }
}
