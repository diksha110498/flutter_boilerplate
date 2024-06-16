import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/src/core/img_picker/repository/aws_upload_image_repository.dart';
import 'package:flutter_boilerplate/src/core/img_picker/state/image_state.dart';
import '../../app_utils/export.dart';

class ImagePickerBloc extends Cubit<ImageState> {
  ImagePickerBloc() : super(ImageState());

  void uploadFileImage(File? image, {type}) {
    if (image != null) {
      EasyLoading.show();
      UploadImageRepository.instance
          .updateCustomerProfileImageApiCall(image)
          .then((value) async {
        if (value.success) {
          uploadImageSwitch(type, value, image);
        }
        EasyLoading.dismiss();
      }).onError((error, stackTrace) {
        EasyLoading.showToast(error.toString());
        EasyLoading.dismiss();
      });
    } else {
      uploadImageSwitch(type, '', null);
    }
  }

  uploadImageSwitch(type, value, image) {
        emit(ImageState(
          image: image,
          uploadedImage: value==''?'':value.data?.name ?? '',
        ));
  }
}
