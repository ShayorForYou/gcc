import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  String accessToken;
  String tokenType;
  int expiresIn;
  User user;

  OtpModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "user": user.toJson(),
  };
}

class User {
  String name;
  int userId;
  String userType;
  Role role;
  int userSl;

  User({
    required this.name,
    required this.userId,
    required this.userType,
    required this.role,
    required this.userSl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    userId: json["user_id"],
    userType: json["user_type"],
    role: Role.fromJson(json["role"]),
    userSl: json["user_sl"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "user_id": userId,
    "user_type": userType,
    "role": role.toJson(),
    "user_sl": userSl,
  };
}

class Role {
  int rolesId;
  String rolesName;
  String status;
  String isStatusPermitted;
  String isCitizen;
  int isDesignationSerial;
  String guardName;
  dynamic createdBy;
  dynamic updatedBy;

  Role({
    required this.rolesId,
    required this.rolesName,
    required this.status,
    required this.isStatusPermitted,
    required this.isCitizen,
    required this.isDesignationSerial,
    required this.guardName,
    required this.createdBy,
    required this.updatedBy,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    rolesId: json["roles_id"],
    rolesName: json["roles_name"],
    status: json["status"],
    isStatusPermitted: json["is_status_permitted"],
    isCitizen: json["is_citizen"],
    isDesignationSerial: json["is_designation_serial"],
    guardName: json["guard_name"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
  );

  Map<String, dynamic> toJson() => {
    "roles_id": rolesId,
    "roles_name": rolesName,
    "status": status,
    "is_status_permitted": isStatusPermitted,
    "is_citizen": isCitizen,
    "is_designation_serial": isDesignationSerial,
    "guard_name": guardName,
    "created_by": createdBy,
    "updated_by": updatedBy,
  };
}
