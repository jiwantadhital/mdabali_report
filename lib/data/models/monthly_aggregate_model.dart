class MonthlyAggregateModel {
  bool? status;
  String? message;
  Data? data;
  String? errors;
  bool? genericMessage;

  MonthlyAggregateModel(
      {this.status, this.message, this.data, this.errors, this.genericMessage});

  MonthlyAggregateModel.fromJson(Map<String, dynamic> json) {
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
  DfsCredit? dfsCredit;
  DfsCredit? dfsDebit;
  Utility? utility;

  Data({this.dfsCredit, this.dfsDebit, this.utility});

  Data.fromJson(Map<String, dynamic> json) {
    dfsCredit = json['dfsCredit'] != null
        ? DfsCredit.fromJson(json['dfsCredit'])
        : null;
    dfsDebit =
        json['dfsDebit'] != null ? DfsCredit.fromJson(json['dfsDebit']) : null;
    utility =
        json['utility'] != null ? Utility.fromJson(json['utility']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dfsCredit != null) {
      data['dfsCredit'] = dfsCredit!.toJson();
    }
    if (dfsDebit != null) {
      data['dfsDebit'] = dfsDebit!.toJson();
    }
    if (utility != null) {
      data['utility'] = utility!.toJson();
    }
    return data;
  }
}

class DfsCredit {
  dynamic previousMonth;
  dynamic currentMonth;

  DfsCredit({this.previousMonth, this.currentMonth});

  DfsCredit.fromJson(Map<String, dynamic> json) {
    previousMonth = _convertNumber(json['previousMonth']);
    currentMonth = _convertNumber(json['currentMonth']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['previousMonth'] = previousMonth;
    data['currentMonth'] = currentMonth;
    return data;
  }

  dynamic _convertNumber(num? value) {
    if (value == null) return null;
    return value % 1 == 0 ? value.toInt() : value.toDouble();
  }
}

class Utility {
  dynamic currentMonth;
  dynamic previousMonth;

  Utility({this.currentMonth, this.previousMonth});

  Utility.fromJson(Map<String, dynamic> json) {
    currentMonth = _convertNumber(json['currentMonth']);
    previousMonth = _convertNumber(json['previousMonth']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentMonth'] = currentMonth;
    data['previousMonth'] = previousMonth;
    return data;
  }

  dynamic _convertNumber(num? value) {
    if (value == null) return null;
    return value % 1 == 0 ? value.toInt() : value.toDouble();
  }
}
