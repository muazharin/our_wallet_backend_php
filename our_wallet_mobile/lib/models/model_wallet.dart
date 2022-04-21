class ResultWalletModel {
  ResultWalletModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<WalletModel>? data;

  factory ResultWalletModel.fromJson(Map<String, dynamic> json) =>
      ResultWalletModel(
        status: json["status"],
        message: json["message"],
        data: List<WalletModel>.from(
            json["data"].map((x) => WalletModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WalletModel {
  WalletModel({
    this.walletId,
    this.walletName,
    this.walletMoney,
    this.walletColor,
    this.walletCreatedAt,
    this.walletUpdatedAt,
    this.walletIsActive,
    this.owId,
    this.owWalletId,
    this.owUserId,
    this.owIsUserActive,
    this.owIsAdmin,
    this.owDate,
  });

  String? walletId;
  String? walletName;
  String? walletMoney;
  String? walletColor;
  DateTime? walletCreatedAt;
  DateTime? walletUpdatedAt;
  String? walletIsActive;
  String? owId;
  String? owWalletId;
  String? owUserId;
  String? owIsUserActive;
  String? owIsAdmin;
  DateTime? owDate;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        walletId: json["walletId"],
        walletName: json["walletName"],
        walletMoney: json["walletMoney"],
        walletColor: json["walletColor"],
        walletCreatedAt: DateTime.parse(json["walletCreatedAt"]),
        walletUpdatedAt: DateTime.parse(json["walletUpdatedAt"]),
        walletIsActive: json["walletIsActive"],
        owId: json["owId"],
        owWalletId: json["owWalletId"],
        owUserId: json["owUserId"],
        owIsUserActive: json["owIsUserActive"],
        owIsAdmin: json["owIsAdmin"],
        owDate: DateTime.parse(json["owDate"]),
      );

  Map<String, dynamic> toJson() => {
        "walletId": walletId,
        "walletName": walletName,
        "walletMoney": walletMoney,
        "walletColor": walletColor,
        "walletCreatedAt": walletCreatedAt!.toIso8601String(),
        "walletUpdatedAt": walletUpdatedAt!.toIso8601String(),
        "walletIsActive": walletIsActive,
        "owId": owId,
        "owWalletId": owWalletId,
        "owUserId": owUserId,
        "owIsUserActive": owIsUserActive,
        "owIsAdmin": owIsAdmin,
        "owDate": owDate!.toIso8601String(),
      };
}

class ResultMemberWalletModel {
  ResultMemberWalletModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<MemberWalletModel>? data;

  factory ResultMemberWalletModel.fromJson(Map<String, dynamic> json) =>
      ResultMemberWalletModel(
        status: json["status"],
        message: json["message"],
        data: List<MemberWalletModel>.from(
            json["data"].map((x) => MemberWalletModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MemberWalletModel {
  MemberWalletModel({
    this.owId,
    this.owWalletId,
    this.owUserId,
    this.owIsUserActive,
    this.owIsAdmin,
    this.owDate,
    this.userId,
    this.userName,
    this.userPassword,
    this.userEmail,
    this.userPhone,
    this.userPhoto,
    this.userGender,
    this.userTglLahir,
    this.userAddress,
    this.userCreatedAt,
    this.userUpdatedAt,
  });

  String? owId;
  String? owWalletId;
  String? owUserId;
  String? owIsUserActive;
  String? owIsAdmin;
  DateTime? owDate;
  String? userId;
  String? userName;
  String? userPassword;
  String? userEmail;
  String? userPhone;
  String? userPhoto;
  String? userGender;
  DateTime? userTglLahir;
  String? userAddress;
  DateTime? userCreatedAt;
  DateTime? userUpdatedAt;

  factory MemberWalletModel.fromJson(Map<String, dynamic> json) =>
      MemberWalletModel(
        owId: json["owId"],
        owWalletId: json["owWalletId"],
        owUserId: json["owUserId"],
        owIsUserActive: json["owIsUserActive"],
        owIsAdmin: json["owIsAdmin"],
        owDate: DateTime.parse(json["owDate"]),
        userId: json["userId"],
        userName: json["userName"],
        userPassword: json["userPassword"],
        userEmail: json["userEmail"],
        userPhone: json["userPhone"],
        userPhoto: json["userPhoto"],
        userGender: json["userGender"],
        userTglLahir: DateTime.parse(json["userTglLahir"]),
        userAddress: json["userAddress"],
        userCreatedAt: DateTime.parse(json["userCreatedAt"]),
        userUpdatedAt: DateTime.parse(json["userUpdatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "owId": owId,
        "owWalletId": owWalletId,
        "owUserId": owUserId,
        "owIsUserActive": owIsUserActive,
        "owIsAdmin": owIsAdmin,
        "owDate": owDate!.toIso8601String(),
        "userId": userId,
        "userName": userName,
        "userPassword": userPassword,
        "userEmail": userEmail,
        "userPhone": userPhone,
        "userPhoto": userPhoto,
        "userGender": userGender,
        "userTglLahir":
            "${userTglLahir!.year.toString().padLeft(4, '0')}-${userTglLahir!.month.toString().padLeft(2, '0')}-${userTglLahir!.day.toString().padLeft(2, '0')}",
        "userAddress": userAddress,
        "userCreatedAt": userCreatedAt!.toIso8601String(),
        "userUpdatedAt": userUpdatedAt!.toIso8601String(),
      };
}

class ResultUserToWalletModel {
  ResultUserToWalletModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<UserToWalletModel>? data;

  factory ResultUserToWalletModel.fromJson(Map<String, dynamic> json) =>
      ResultUserToWalletModel(
        status: json["status"],
        message: json["message"],
        data: List<UserToWalletModel>.from(
            json["data"].map((x) => UserToWalletModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UserToWalletModel {
  UserToWalletModel({
    this.userId,
    this.userName,
    this.userPassword,
    this.userEmail,
    this.userPhone,
    this.userPhoto,
    this.userGender,
    this.userTglLahir,
    this.userAddress,
    this.userCreatedAt,
    this.userUpdatedAt,
  });

  String? userId;
  String? userName;
  String? userPassword;
  String? userEmail;
  String? userPhone;
  String? userPhoto;
  String? userGender;
  DateTime? userTglLahir;
  String? userAddress;
  DateTime? userCreatedAt;
  DateTime? userUpdatedAt;

  factory UserToWalletModel.fromJson(Map<String, dynamic> json) =>
      UserToWalletModel(
        userId: json["userId"],
        userName: json["userName"],
        userPassword: json["userPassword"],
        userEmail: json["userEmail"],
        userPhone: json["userPhone"],
        userPhoto: json["userPhoto"],
        userGender: json["userGender"],
        userTglLahir: DateTime.parse(json["userTglLahir"]),
        userAddress: json["userAddress"],
        userCreatedAt: DateTime.parse(json["userCreatedAt"]),
        userUpdatedAt: DateTime.parse(json["userUpdatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "userPassword": userPassword,
        "userEmail": userEmail,
        "userPhone": userPhone,
        "userPhoto": userPhoto,
        "userGender": userGender,
        "userTglLahir":
            "${userTglLahir!.year.toString().padLeft(4, '0')}-${userTglLahir!.month.toString().padLeft(2, '0')}-${userTglLahir!.day.toString().padLeft(2, '0')}",
        "userAddress": userAddress,
        "userCreatedAt": userCreatedAt!.toIso8601String(),
        "userUpdatedAt": userUpdatedAt!.toIso8601String(),
      };
}
