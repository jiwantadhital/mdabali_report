class TopupSummaryModel {
  bool? status;
  String? message;
  Data? data;
  String? errors;
  bool? genericMessage;

  TopupSummaryModel(
      {this.status, this.message, this.data, this.errors, this.genericMessage});

  TopupSummaryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'];
    genericMessage = json['genericMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['errors'] = errors;
    data['genericMessage'] = genericMessage;
    return data;
  }
}

class Data {
  double? remainingBalance;
  double? transactionAmount;
  int? transactionCount;

  Data({this.remainingBalance, this.transactionAmount, this.transactionCount});

  Data.fromJson(Map<String, dynamic> json) {
    remainingBalance = json['remainingBalance'];
    transactionAmount = json['transactionAmount'];
    transactionCount = json['transactionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remainingBalance'] = remainingBalance;
    data['transactionAmount'] = transactionAmount;
    data['transactionCount'] = transactionCount;
    return data;
  }
}
