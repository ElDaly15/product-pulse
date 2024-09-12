class ReactionModel {
  final String name;
  final String image;
  final String uid;
  final String email;

  ReactionModel(
      {required this.name,
      required this.image,
      required this.uid,
      required this.email});

  factory ReactionModel.jsonData(json) {
    return ReactionModel(
        name: json['name'],
        image: json['image'],
        uid: json['uid'],
        email: json['email']);
  }
}
