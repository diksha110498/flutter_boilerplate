class RefreshTokenResponseModel {
  bool ?success;
  RefreshTokenDataModel ?data;

  RefreshTokenResponseModel({this.success, this.data});

  RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new RefreshTokenDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RefreshTokenDataModel {
  String ?accessToken;

  RefreshTokenDataModel({this.accessToken});

  RefreshTokenDataModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    return data;
  }
}