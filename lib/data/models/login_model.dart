class LoginModel {
  Data? data;
  bool? isOTPRequired;
  String? message;
  bool? status;

  LoginModel({this.data, this.isOTPRequired, this.message, this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    isOTPRequired = json['isOTPRequired'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['isOTPRequired'] = this.isOTPRequired;
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Data {
  String? secretKey;
  String? secret;

  Data({this.secretKey, this.secret});

  Data.fromJson(Map<String, dynamic> json) {
    secretKey = json['secretKey'];
    secret = json['secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secretKey'] = secretKey;
    data['secret'] = secret;
    return data;
  }
}

// class LoginModel {
//   Data? data;
//   bool? isOTPRequired;
//   String? message;
//   //String? errors;
//   bool? status;

//   LoginModel(
//       {this.data,
//       this.isOTPRequired,
//       this.message,
//       // this.errors,
//       this.status});

//   LoginModel.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     isOTPRequired = json['isOTPRequired'];
//     message = json['message'];
//     // errors = json['errors'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['isOTPRequired'] = isOTPRequired;
//     data['message'] = message;
//     // data['errors'] = errors;
//     data['status'] = status;
//     return data;
//   }
// }

// class Data {
//   String? secretKey;
//   String? secret;
// //   String? accessToken;
// //   String? tokenType;
// //   String? refreshToken;
// //   int? expiresIn;
// //   String? scope;

//   Data({
//     this.secretKey,
//     this.secret,
//     //   this.accessToken,
//     //   this.tokenType,
//     //   this.refreshToken,
//     //   this.expiresIn,
//     //   this.scope
//   });

//   Data.fromJson(Map<String, dynamic> json) {
//     secretKey = json['secretKey'];
//     secret = json[secret];
//     // accessToken = json['access_token'];
//     // tokenType = json['token_type'];
//     // refreshToken = json['refresh_token'];
//     // expiresIn = json['expires_in'];
//     // scope = json['scope'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['secretKey'] = secretKey;
//     data['secret'] = secret;
//     // data['access_token'] = accessToken;
//     // data['token_type'] = tokenType;
//     // data['refresh_token'] = refreshToken;
//     // data['expires_in'] = expiresIn;
//     // data['scope'] = scope;
//     return data;
//   }
// }
