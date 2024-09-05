class ReactionModel {
  final String name;
  final String image;
  final String uid;

  ReactionModel({required this.name, required this.image, required this.uid});

  factory ReactionModel.jsonData(json) {
    return ReactionModel(
        name: json['name'], image: json['image'], uid: json['uid']);
  }
}
