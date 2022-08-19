class Photo {
  int? id;
  String? image;

  Photo(this.id, this.image);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'image': image,
    };
    return map;
  }

  Photo.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    image = map['image'];
  }
}
