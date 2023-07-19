import 'dart:convert';
import 'package:equatable/equatable.dart';

List<RestaurantsModel> restaurantsModelFromJson(String str) =>
    List<RestaurantsModel>.from(
        json.decode(str).map((x) => RestaurantsModel.fromJson(x)));

String restaurantsModelToJson(List<RestaurantsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantsModel extends Equatable {
  final int? id;
  final String? name;
  final String? neighborhood;
  final String? photograph;
  final String? address;
  final Latlng? latlng;
  final String? cuisineType;
  final OperatingHours? operatingHours;
  final List<Review>? reviews;

  const RestaurantsModel({
    this.id,
    this.name,
    this.neighborhood,
    this.photograph,
    this.address,
    this.latlng,
    this.cuisineType,
    this.operatingHours,
    this.reviews,
  });

  RestaurantsModel copyWith({
    int? id,
    String? name,
    String? neighborhood,
    String? photograph,
    String? address,
    Latlng? latlng,
    String? cuisineType,
    OperatingHours? operatingHours,
    List<Review>? reviews,
  }) =>
      RestaurantsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        neighborhood: neighborhood ?? this.neighborhood,
        photograph: photograph ?? this.photograph,
        address: address ?? this.address,
        latlng: latlng ?? this.latlng,
        cuisineType: cuisineType ?? this.cuisineType,
        operatingHours: operatingHours ?? this.operatingHours,
        reviews: reviews ?? this.reviews,
      );

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) =>
      RestaurantsModel(
        id: json["id"],
        name: json["name"],
        neighborhood: json["neighborhood"],
        photograph: json["photograph"],
        address: json["address"],
        latlng: json["latlng"] == null ? null : Latlng.fromJson(json["latlng"]),
        cuisineType: json["cuisine_type"],
        operatingHours: json["operating_hours"] == null
            ? null
            : OperatingHours.fromJson(json["operating_hours"]),
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "neighborhood": neighborhood,
        "photograph": photograph,
        "address": address,
        "latlng": latlng?.toJson(),
        "cuisine_type": cuisineType,
        "operating_hours": operatingHours?.toJson(),
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        neighborhood,
        photograph,
        address,
        latlng,
        cuisineType,
        operatingHours,
        reviews
      ];
}

class Latlng extends Equatable {
  final double? lat;
  final double? lng;

  const Latlng({
    this.lat,
    this.lng,
  });

  Latlng copyWith({
    double? lat,
    double? lng,
  }) =>
      Latlng(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Latlng.fromJson(Map<String, dynamic> json) => Latlng(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };

  @override
  List<Object?> get props => [lat, lng];
}

class OperatingHours extends Equatable {
  final String? monday;
  final String? tuesday;
  final String? wednesday;
  final String? thursday;
  final String? friday;
  final String? saturday;
  final String? sunday;

  const OperatingHours({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  OperatingHours copyWith({
    String? monday,
    String? tuesday,
    String? wednesday,
    String? thursday,
    String? friday,
    String? saturday,
    String? sunday,
  }) =>
      OperatingHours(
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
        thursday: thursday ?? this.thursday,
        friday: friday ?? this.friday,
        saturday: saturday ?? this.saturday,
        sunday: sunday ?? this.sunday,
      );

  factory OperatingHours.fromJson(Map<String, dynamic> json) => OperatingHours(
        monday: json["Monday"],
        tuesday: json["Tuesday"],
        wednesday: json["Wednesday"],
        thursday: json["Thursday"],
        friday: json["Friday"],
        saturday: json["Saturday"],
        sunday: json["Sunday"],
      );

  Map<String, dynamic> toJson() => {
        "Monday": monday,
        "Tuesday": tuesday,
        "Wednesday": wednesday,
        "Thursday": thursday,
        "Friday": friday,
        "Saturday": saturday,
        "Sunday": sunday,
      };

  @override
  List<Object?> get props =>
      [monday, tuesday, wednesday, thursday, friday, saturday, sunday];
}

class Review extends Equatable {
  final String? name;
  final String? date;
  final int? rating;
  final String? comments;

  const Review({
    this.name,
    this.date,
    this.rating,
    this.comments,
  });

  Review copyWith({
    String? name,
    String? date,
    int? rating,
    String? comments,
  }) =>
      Review(
        name: name ?? this.name,
        date: date ?? this.date,
        rating: rating ?? this.rating,
        comments: comments ?? this.comments,
      );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["name"],
        date: json["date"],
        rating: json["rating"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
        "rating": rating,
        "comments": comments,
      };

  @override
  List<Object?> get props => [name, date, rating, comments];
}
