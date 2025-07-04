class UserModel {
  final String uid;
  final String? email;

  UserModel({required this.uid, this.email});

  factory UserModel.fromFirebaseUser(dynamic user) {
    return UserModel(uid: user.uid, email: user.email);
  }
}
