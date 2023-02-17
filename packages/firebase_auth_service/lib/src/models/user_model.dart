import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel(
      {required this.uid, this.email, this.name, this.photo, this.date});

  final String uid;
  final String? email;
  final String? name;
  final String? photo;
  final DateTime? date;

  static const empty = UserModel(uid: '');

  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? photo,
    DateTime? date,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        photo: photo ?? this.photo,
        date: date ?? this.date,
      );

  factory UserModel.fromJson(Map<Object?, dynamic> json) => UserModel(
        uid: json["uid"],
        email: json["email"],
        name: json["name"],
        photo: json["photo"],
        date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "photo": photo,
      };

  @override
  List<Object?> get props => [uid, email, name, photo, date];
}
