class SummaryReportModel {
  bool? status;
  String? message;
  List<Data>? data;
  List<String>? error;
  bool? genericMessage;

  SummaryReportModel(
      {this.status, this.message, this.data, this.error, this.genericMessage});

  SummaryReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    error = json['error'] != null
        ? (json['error'] as List).map((e) => e.toString()).toList()
        : null;
    genericMessage = json['genericMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    data['genericMessage'] = genericMessage;
    return data;
  }
}

class Data {
  double? successAmount;
  int? pendingCount;
  String? services;
  String? serviceIcon;
  double? failedAmount;
  int? failedCount;
  double? pendingAmount;
  int? successCount;

  Data(
      {this.successAmount,
      this.pendingCount,
      this.services,
      this.serviceIcon,
      this.failedAmount,
      this.failedCount,
      this.pendingAmount,
      this.successCount});

  Data.fromJson(Map<String, dynamic> json) {
    successAmount = json['successAmount'];
    pendingCount = json['pendingCount'];
    services = json['services'];
    serviceIcon = json['serviceIcon'];
    failedAmount = json['failedAmount'];
    failedCount = json['failedCount'];
    pendingAmount = json['pendingAmount'];
    successCount = json['successCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['successAmount'] = successAmount;
    data['pendingCount'] = pendingCount;
    data['services'] = services;
    data['serviceIcon'] = serviceIcon;
    data['failedAmount'] = failedAmount;
    data['failedCount'] = failedCount;
    data['pendingAmount'] = pendingAmount;
    data['successCount'] = successCount;
    return data;
  }
}
