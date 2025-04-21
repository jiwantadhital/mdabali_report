class MemeberLimitModel {
  bool? status;
  String? message;
  Data? data;
  String? errors;

  MemeberLimitModel({this.status, this.message, this.data, this.errors});

  MemeberLimitModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['errors'] = errors;
    return data;
  }
}

class Data {
  int? closedUser;
  int? verifiedUser;
  int? totalUser;
  int? memberLimit;

  Data({this.closedUser, this.verifiedUser, this.totalUser, this.memberLimit});

  Data.fromJson(Map<String, dynamic> json) {
    closedUser = json['closedUser'];
    verifiedUser = json['verifiedUser'];
    totalUser = json['totalUser'];
    memberLimit = json['memberLimit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['closedUser'] = closedUser;
    data['verifiedUser'] = verifiedUser;
    data['totalUser'] = totalUser;
    data['memberLimit'] = memberLimit;
    return data;
  }
}
