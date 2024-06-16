class UploadImageResponseModel {
  bool success;
  UploadImageDataModel ?data;

  UploadImageResponseModel(this.success, this.data);

  UploadImageResponseModel.fromJson(Map<String, dynamic> data)
      : success = data['success'],
        data = data['data']!=null?UploadImageDataModel.fromJson(data['data']):null;
}
class UploadImageDataModel{
  String name;
  UploadImageDataModel(this.name);
  UploadImageDataModel.fromJson(Map<String,dynamic> data):
      name=data['name'];
}