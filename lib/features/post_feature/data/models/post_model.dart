import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String firstName;
  final String lastName;
  final String postId;
  final String title;
  final String userEmail;
  final String userId;
  final String userImage;
  final String image;
  final List<dynamic> likes;
  final List<dynamic> comments;
  final Timestamp? timestamp;

  PostModel(
      {required this.firstName,
      required this.lastName,
      required this.postId,
      required this.title,
      required this.userEmail,
      required this.userId,
      required this.userImage,
      required this.image,
      required this.likes,
      required this.comments,
      required this.timestamp});

  factory PostModel.fromJson(json) {
    return PostModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        postId: json['postId'],
        title: json['title'],
        userEmail: json['userEmail'],
        userId: json['userId'],
        userImage: json['userImage'],
        image: json['image'],
        likes: json['likes'],
        comments: json['comments'],
        timestamp: json['postTime']);
  }
}
