/*class UserModel {
  String? uid;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? password;
  UserModel({this.uid, this.email, this.fullName, this.phoneNumber, this.password});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}*/