import 'package:image_picker/image_picker.dart';
import 'package:flutter_boilerplate/src/core/app_utils/export.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(XFile)? onImageSelected;

  const ImagePickerBottomSheet({Key? key, this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text('Take a photo'),
          onTap: () async {
            final pickedFile =
                await ImagePicker().pickImage(source: ImageSource.camera);
            if (pickedFile != null) {
              onImageSelected?.call(pickedFile);
            }
            NavigationService.goBack();
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Choose from gallery'),
          onTap: () async {
            final pickedFile =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              onImageSelected?.call(pickedFile);
            }
            NavigationService.goBack();
          },
        ),
      ],
    );
  }
}
