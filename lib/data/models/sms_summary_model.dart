class SmsSummaryModel {
  bool? status;
  String? message;
  Data? data;
  String? errors;

  SmsSummaryModel({this.status, this.message, this.data, this.errors});

  SmsSummaryModel.fromJson(Map<String, dynamic> json) {
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
  int? smsCount;
  int? availableCount;
  double? smsRate;
  double? totalAmount;

  Data({this.smsCount, this.availableCount, this.smsRate, this.totalAmount});

  Data.fromJson(Map<String, dynamic> json) {
    smsCount = json['smsCount'];
    availableCount = json['availableCount'];
    smsRate = json['smsRate'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['smsCount'] = smsCount;
    data['availableCount'] = availableCount;
    data['smsRate'] = smsRate;
    data['totalAmount'] = totalAmount;
    return data;
  }
}
