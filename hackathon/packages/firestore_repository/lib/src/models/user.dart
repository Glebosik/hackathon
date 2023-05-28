import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.email,
    this.phoneNumber,
    this.firstName,
    this.secondName,
    this.thirdName,
    required this.approved,
  });

  final String? email;
  final String? phoneNumber;
  final String? firstName;
  final String? secondName;
  final String? thirdName;
  final bool approved;

  factory User.fromFirestore(Map data) {
    return User(
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      firstName: data['firstName'],
      secondName: data['secondName'],
      thirdName: data['thirdName'],
      approved: data['approved'],
    );
  }

  @override
  List<Object?> get props =>
      [email, phoneNumber, firstName, secondName, thirdName, approved];
}
