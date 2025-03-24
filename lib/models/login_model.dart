import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String accessToken;
  String tokenType;
  int expiresIn;
  User user;

  LoginModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  int id;
  String userType;
  Role role;

  User({
    required this.name,
    required this.id,
    required this.userType,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    id: json["id"],
    userType: json["user_type"],
    role: Role.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "user_type": userType,
    "role": role.toJson(),
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
