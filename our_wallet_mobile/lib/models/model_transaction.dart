class ResultTransactionModel {
  ResultTransactionModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<TransactionModel>? data;

  factory ResultTransactionModel.fromJson(Map<String, dynamic> json) =>
      ResultTransactionModel(
        status: json["status"],
        message: json["message"],
        data: List<TransactionModel>.from(
            json["data"].map((x) => TransactionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TransactionModel {
  TransactionModel({
    this.id,
    this.userId,
    this.walletId,
    this.type,
    this.transactionDetail,
    this.userDetail,
    this.walletDetail,
    this.file,
  });

  String? id;
  String? userId;
  String? walletId;
  String? type;
  TransactionDetail? transactionDetail;
  UserDetail? userDetail;
  WalletDetail? walletDetail;
  List<FileElement>? file;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        userId: json["userId"],
        walletId: json["walletId"],
        type: json["type"],
        transactionDetail:
            TransactionDetail.fromJson(json["transactionDetail"]),
        userDetail: UserDetail.fromJson(json["userDetail"]),
        walletDetail: WalletDetail.fromJson(json["walletDetail"]),
        file: List<FileElement>.from(
            json["file"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "walletId": walletId,
        "type": type,
        "transactionDetail": transactionDetail!.toJson(),
        "userDetail": userDetail!.toJson(),
        "walletDetail": walletDetail!.toJson(),
        "file": List<dynamic>.from(file!.map((x) => x.toJson())),
      };
}

class FileElement {
  FileElement({
    this.tfId,
    this.tfFile,
  });

  String? tfId;
  String? tfFile;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        tfId: json["tfId"],
        tfFile: json["tfFile"],
      );

  Map<String, dynamic> toJson() => {
        "tfId": tfId,
        "tfFile": tfFile,
      };
}

class TransactionDetail {
  TransactionDetail({
    this.title,
    this.detail,
    this.price,
    this.date,
  });

  String? title;
  String? detail;
  String? price;
  DateTime? date;

  factory TransactionDetail.fromJson(Map<String, dynamic> json) =>
      TransactionDetail(
        title: json["title"],
        detail: json["detail"],
        price: json["price"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "detail": detail,
        "price": price,
        "date": date!.toIso8601String(),
      };
}

class UserDetail {
  UserDetail({
    this.name,
    this.email,
    this.photo,
    this.phone,
  });

  String? name;
  String? email;
  String? photo;
  String? phone;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        name: json["name"],
        email: json["email"],
        photo: json["photo"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "photo": photo,
        "phone": phone,
      };
}

class WalletDetail {
  WalletDetail({
    this.name,
    this.color,
  });

  String? name;
  String? color;

  factory WalletDetail.fromJson(Map<String, dynamic> json) => WalletDetail(
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "color": color,
      };
}
