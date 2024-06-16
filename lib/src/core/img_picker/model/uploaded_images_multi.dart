class UploadedMultiImageResponseModel {
  bool? success;
  List<MultiImagesData>? data;

  UploadedMultiImageResponseModel({this.success, this.data});

  UploadedMultiImageResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <MultiImagesData>[];
      json['data'].forEach((v) {
        data!.add(new MultiImagesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MultiImagesData {
  String? name;

  MultiImagesData({this.name});

  MultiImagesData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
