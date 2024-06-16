import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_picker_dialog.dart';

class ImagePickerHandler {
  final ImagePicker _picker = ImagePicker();
  ImagePickerDialog ?imagePicker;
  ImagePickerListener _listener;
  BuildContext ?context;


  ImagePickerHandler(this._listener);

  openCamera() async {
    imagePicker?.dismissDialog();
    var image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    selectedImage(image!);
  }

  closeDialog() {
    imagePicker?.dismissDialog();
  }

  openGallery() async {

    imagePicker?.dismissDialog();
    var image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    selectedImage(image!);
  }


  void init() {
    imagePicker = new ImagePickerDialog(this);
    imagePicker?.initState();
  }

  Future selectedImage(XFile image) async {
    _listener.selectedProfileImage(
        image);
  }

  showDialog(BuildContext context,
      {bool profileImage = false,
      bool docImage1 = false,
      bool docImage2 = false,
      bool docImage3 = false,
      bool docCertificateImage1 = false,
      bool docCertificateImage2 = false,
      bool docCertificateImage3 = false}) {
    this.context = context;
    imagePicker?.getImage(context);
  }
}

abstract class ImagePickerListener {
  selectedProfileImage(
    XFile _image,
  );
}
