class City {
  final String place;

  City({required this.place});

  Map<String, dynamic> toJson() {
    return {
      'place': place,
    };
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return  City(place: json['place']);
  }

}
