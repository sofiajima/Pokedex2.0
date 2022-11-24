class Pokemon {
  int id;
  String name;
  String image;
  String type;

  Pokemon({this.id, this.name, this.image, this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'type': type,
    };
  }
}