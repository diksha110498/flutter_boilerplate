class ImageRequestModel {
  String ?image;

  ImageRequestModel(this.image);

  toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.image;
    return data;
  }

  ImageRequestModel.fromJson(Map<String, dynamic> data) {
    this.image = data['name'];
  }
}
