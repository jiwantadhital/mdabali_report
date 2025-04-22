class TOtpModel {
  Data? data;
  bool? isOTPRequired;
  String? message;
  String? errors;
  bool? status;

  TOtpModel(
      {this.data, this.isOTPRequired, this.message, this.errors, this.status});

  TOtpModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    isOTPRequired = json['isOTPRequired'];
    message = json['message'];
    errors = json['errors'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['isOTPRequired'] = isOTPRequired;
    data['message'] = message;
    data['errors'] = errors;
    data['status'] = status;
    return data;
  }
}

class Data {
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? expiresIn;
  String? scope;

  Data(
      {this.accessToken,
      this.refreshToken,
      this.tokenType,
      this.expiresIn,
      this.scope});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['scope'] = scope;
    return data;
  }
}
