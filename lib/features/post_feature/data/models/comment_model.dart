class CommentModel {
  final String name;
  final String image;
  final String comment;
  final String uid;

  CommentModel(
      {required this.name,
      required this.image,
      required this.comment,
      required this.uid});

  factory CommentModel.jsonData(json) {
    return CommentModel(
        name: json['userName'],
        image: json['userImage'],
        comment: json['comment'],
        uid: json['uid']);
  }
}
