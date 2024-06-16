class ErrorResponseModel {
  bool? success;
  bool? data;
  String ?message;
  int? statusCode;

  ErrorResponseModel({
    this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('success')) {
      // It's a failure response
      return ErrorResponseModel(
        success: json['success']??false,
        message: json['message'],
        data: json['data'],
      );
    } else if (json.containsKey('message')) {
      // It's an error response
      dynamic getMessage = json['message'];
      if (getMessage is List) {
        // It's a list, indicating an error response
        return ErrorResponseModel(
          message: List<String>.from(getMessage).first,
          statusCode: json['statusCode'],
        );
      } else if (getMessage is String) {
        // It's a string, indicating a failure response
        return ErrorResponseModel(
          success: false,
          message: getMessage,
        );
      }
    }
    throw FormatException("Invalid JSON format");
  }
}
