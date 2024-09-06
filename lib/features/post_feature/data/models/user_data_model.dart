class UserDataModel {
  final String firstName;
  final String lastName;
  final String image;
  final String uid;
  final String email;
  final String bestProduct;
  final String birthDay;
  final String birthMonth;
  final String birthYear;
  final String gender;
  final String fullName;

  UserDataModel(
      {required this.firstName,
      required this.lastName,
      required this.image,
      required this.uid,
      required this.email,
      required this.bestProduct,
      required this.birthDay,
      required this.birthMonth,
      required this.birthYear,
      required this.gender,
      required this.fullName});

  factory UserDataModel.fromJson(json) {
    return UserDataModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        image: json['image'],
        uid: json['uid'],
        email: json['email'],
        bestProduct: json['bestProduct'],
        birthDay: json['birthDay'],
        birthMonth: json['birthMonth'],
        birthYear: json['birthYear'],
        gender: json['Gender'],
        fullName: json['fullName']);
  }
}
