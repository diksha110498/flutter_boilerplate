
import 'dart:io';
import 'package:flutter_boilerplate/src/core/environments/environment.dart';
import 'package:flutter_boilerplate/src/core/models/upload_file_response.dart';
import 'package:flutter_boilerplate/src/core/network/dio_base_service.dart';

class AppRepository extends DioBaseService{

  AppRepository._() :super(Environment().config.apiHost);
  static AppRepository? _instance;
  static AppRepository get instance => _instance ??= AppRepository._();

  static const _upload = 'uploads/upload';

  Future<UploadFileResponse> uploadFileRequest(File imageFile) async {
    try {
      final response = await uploadImage(_upload, imageFile, (double progress) {
            print("Progress:=${progress}");
            // Update your UI or perform other actions based on the progress
          });
      final uploadFileResponse = uploadFileResponseFromJson(response as String);
      return uploadFileResponse;

    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

}
