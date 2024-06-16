import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_boilerplate/src/core/img_picker/model/uploaded_images_multi.dart';
import 'package:flutter_boilerplate/src/core/network/dio_base_service.dart';

import '../../../../modules/authentication_module/models/success_response_model.dart';
import '../../app_utils/export.dart';
import '../model/upload_image_response_model.dart';

class UploadImageRepository extends DioBaseService {
  UploadImageRepository._()
      : super(Environment().config.apiHost + Environment().config.awsPath);
  static UploadImageRepository? _instance;

  static UploadImageRepository get instance =>
      _instance ??= UploadImageRepository._();
  final String uploadImageEndPoint = 'upload-image';
  final String uploadMultiImageEndPoint = 'upload-multiple-images';

  Future<UploadImageResponseModel> updateCustomerProfileImageApiCall(
      File image) async {
    try {
      Map<String, dynamic> data = new Map<String, dynamic>();
      data['image'] =
          await MultipartFile.fromFile(image.path, filename: image.path);
      final response = await post(uploadImageEndPoint, data);
      return UploadImageResponseModel.fromJson(jsonDecode(response));
    } catch (e) {
      print('upload aws error $e');
      return Future.error(e);
    }
  }

  Future<UploadedMultiImageResponseModel> updateMultipleImageApiCall(
      List<XFile> xImages) async {
    try {
      Map<String, dynamic> data = new Map<String, dynamic>();
      List<File> images = xImages.map((xFile) => File(xFile.path)).toList();

      FormData formData = FormData();

      for (File image in images) {
        formData.files.add(
          MapEntry(
            'images',
            await MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            ),
          ),
        );
      }


      final response = await post(uploadMultiImageEndPoint,data ,newData: formData);
      return UploadedMultiImageResponseModel.fromJson(jsonDecode(response));
    } catch (e) {
      print('upload aws error $e');
      return Future.error(e);
    }
  }
}
