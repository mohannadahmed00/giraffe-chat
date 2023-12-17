import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  late final String? id;
  late final String? imgUrl;
  late final String? name;
  late final String? email;
  late final Timestamp? createdAt;
  late final Timestamp? lastActive;
  late final String? pushToken;
  late final bool? isOnline;

  UserEntity(
      {this.id,
      this.imgUrl,
      this.name,
      this.email,
      this.createdAt,
      this.lastActive,
      this.pushToken,
      this.isOnline});

  UserEntity.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    imgUrl = json["imgUrl"];
    name = json["name"];
    email = json["email"];
    createdAt = json["createdAt"];
    lastActive = json["lastActive"];
    pushToken = json["pushToken"];
    isOnline = json["isOnline"];
  }

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    _json["id"] = id;
    _json["imgUrl"] = imgUrl;
    _json["name"] = name;
    _json["email"] = email;
    _json["createdAt"] = createdAt;
    _json["lastActive"] = lastActive;
    _json["pushToken"] = pushToken;
    _json["isOnline"] = isOnline;
    return _json;
  }
}
