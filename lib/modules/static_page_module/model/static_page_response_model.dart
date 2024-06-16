class StaticPageResponseModel {
  bool? success;
  StaticPageDataModel? data;

  StaticPageResponseModel({this.success, this.data});

  StaticPageResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new StaticPageDataModel.fromJson(json['data']) : null;
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

class StaticPageDataModel {
  int? id;
  int? brandId;
  String? message;
  String? type;
  int? status;
  String? created;
  String? modified;

  StaticPageDataModel(
      {this.id,
        this.brandId,
        this.message,
        this.type,
        this.status,
        this.created,
        this.modified});

  StaticPageDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brand_id'];
    message = json['message'];
    type = json['type'];
    status = json['status'];
    created = json['created'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_id'] = this.brandId;
    data['message'] = this.message;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created'] = this.created;
    data['modified'] = this.modified;
    return data;
  }
}