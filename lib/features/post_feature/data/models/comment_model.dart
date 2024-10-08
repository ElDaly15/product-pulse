class CommentModel {
  final String name;
  final String image;
  final String comment;
  final String uid;
  final String commentId;
  final String email;

  CommentModel(
      {required this.name,
      required this.image,
      required this.comment,
      required this.uid,
      required this.commentId,
      required this.email});

  factory CommentModel.jsonData(json) {
    return CommentModel(
        name: json['userName'],
        image: json['userImage'],
        comment: json['comment'],
        uid: json['uid'],
        commentId: json['commentId'],
        email: json['email']);
  }
}
