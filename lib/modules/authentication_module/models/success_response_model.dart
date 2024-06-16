class SuccessResponseModel {
  bool success;
  String message;
  bool data;

  SuccessResponseModel(this.message, this.success,this.data);

  SuccessResponseModel.fromJson(Map<String, dynamic> data)
      : this.success = data['success']??false,
        this.message = data['message']??"",
        this.data = data['data']??false;
}
