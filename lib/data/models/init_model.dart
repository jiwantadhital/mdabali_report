class InitModel {
  bool? status;
  String? message;
  Data? data;
  String? errors;
  bool? genericMessage;

  InitModel(
      {this.status, this.message, this.data, this.errors, this.genericMessage});

  InitModel.fromJson(Map<String, dynamic> json) {
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
  String? clientName;
  int? clientId;

  Data({this.clientName, this.clientId});

  Data.fromJson(Map<String, dynamic> json) {
    clientName = json['clientName'];
    clientId = json['clientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientName'] = clientName;
    data['clientId'] = clientId;
    return data;
  }
}
