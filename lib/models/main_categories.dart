// ignore: camel_case_types
class categories {
  int id;
  String name;
  int parent;
  photo image;

  categories({this.id, this.name, this.parent, this.image});

  factory categories.fromJson(Map<String, dynamic> json) {
    return categories(
      id: json['id'] as int,
      name: json['name'] as String,
      parent: json['paren'] as int,
      image: json['image'] != null ? photo.fromJson(json['image']) : null,
    );
  }
}

// ignore: camel_case_types
class photo {
  String src;

  photo({
    this.src,
  });

  factory photo.fromJson(Map<String, dynamic> json) {
    return photo(
      src: json['src'] as String,
    );
  }
}
