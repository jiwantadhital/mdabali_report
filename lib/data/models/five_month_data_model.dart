class FiveMonthDataModel {
  bool? status;
  String? message;
  Data? data;
  String? errors;
  bool? genericMessage;

  FiveMonthDataModel(
      {this.status, this.message, this.data, this.errors, this.genericMessage});

  FiveMonthDataModel.fromJson(Map<String, dynamic> json) {
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
  List<DfsCredit>? dfsCredit;
  List<DfsDebit>? dfsDebit;
  List<Utility>? utility;

  Data({this.dfsCredit, this.dfsDebit, this.utility});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['dfsCredit'] != null) {
      dfsCredit = <DfsCredit>[];
      json['dfsCredit'].forEach((v) {
        dfsCredit!.add(DfsCredit.fromJson(v));
      });
    }
    if (json['dfsDebit'] != null) {
      dfsDebit = <DfsDebit>[];
      json['dfsDebit'].forEach((v) {
        dfsDebit!.add(DfsDebit.fromJson(v));
      });
    }
    if (json['utility'] != null) {
      utility = <Utility>[];
      json['utility'].forEach((v) {
        utility!.add(Utility.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dfsCredit != null) {
      data['dfsCredit'] = dfsCredit!.map((v) => v.toJson()).toList();
    }
    if (dfsDebit != null) {
      data['dfsDebit'] = dfsDebit!.map((v) => v.toJson()).toList();
    }
    if (utility != null) {
      data['utility'] = utility!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DfsDebit {
  String? month;
  double? amount;

  DfsDebit({this.month, this.amount});

  DfsDebit.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['amount'] = amount;
    return data;
  }
}

class DfsCredit {
  String? month;
  double? amount;

  DfsCredit({this.month, this.amount});

  DfsCredit.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['amount'] = amount;
    return data;
  }
}

class Utility {
  String? month;
  double? amount;

  Utility({this.month, this.amount});

  Utility.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['amount'] = amount;
    return data;
  }
}
