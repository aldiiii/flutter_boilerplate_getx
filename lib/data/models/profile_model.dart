// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

class ProfileModel {
  ProfileModel({
    this.user,
    this.token,
  });

  User user;
  String token;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.slug,
    this.username,
    this.code,
    this.referral,
    this.avatar,
    this.contact,
    this.email,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  dynamic slug;
  dynamic username;
  dynamic code;
  dynamic referral;
  dynamic avatar;
  String contact;
  String email;
  dynamic emailVerifiedAt;
  dynamic twoFactorSecret;
  dynamic twoFactorRecoveryCodes;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        username: json["username"],
        code: json["code"],
        referral: json["referral"],
        avatar: json["avatar"],
        contact: json["contact"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "username": username,
        "code": code,
        "referral": referral,
        "avatar": avatar,
        "contact": contact,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
