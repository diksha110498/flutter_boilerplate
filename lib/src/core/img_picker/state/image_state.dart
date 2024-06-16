import 'dart:io';

class ImageState {
  File? image;
  String? uploadedImage;

  File? idCardFront;
  File? idCardBack;
  File? drivingLicense;
  File? socialInsurance;
  File? healthCard;
  File? professionalId;
  String? idCardFrontUploaded;
  String? idCardBackUploaded;
  String? drivingLicenseUploaded;
  String? socialInsuranceUploaded;
  String? healthCardUploaded;
  String? professionalIdUploaded;

  ImageState({
    this.uploadedImage,
    this.image,
    this.idCardFront,
    this.idCardBack,
    this.drivingLicense,
    this.healthCard,
    this.professionalId,
    this.socialInsurance,
    this.idCardFrontUploaded,
    this.idCardBackUploaded,
    this.drivingLicenseUploaded,
    this.healthCardUploaded,
    this.professionalIdUploaded,
    this.socialInsuranceUploaded,
  });
}
