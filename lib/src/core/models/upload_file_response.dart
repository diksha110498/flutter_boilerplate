// To parse this JSON data, do
//
//     final uploadFileResponse = uploadFileResponseFromJson(jsonString);

import 'dart:convert';

UploadFileResponse uploadFileResponseFromJson(String str) => UploadFileResponse.fromJson(json.decode(str));

String uploadFileResponseToJson(UploadFileResponse data) => json.encode(data.toJson());

class UploadFileResponse {
  String filename;
  String originalname;
  String path;

  UploadFileResponse({
    required this.filename,
    required this.originalname,
    required this.path,
  });

  factory UploadFileResponse.fromJson(Map<String, dynamic> json) => UploadFileResponse(
    filename: json["filename"],
    originalname: json["originalname"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "filename": filename,
    "originalname": originalname,
    "path": path,
  };
}
