import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/core/app_theme/app_theme.dart';
import '../../app_theme/app_colors.dart';
import '../../app_utils/app_sizes.dart';
import 'image_picker_handler.dart';
class ImagePickerDialog extends StatelessWidget {
  ImagePickerHandler _listener;
  BuildContext ?context;

  ImagePickerDialog(this._listener);

  void initState() {}

  getImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );
  }

  dismissDialog() {
    Navigator.pop(context!);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return dialogView();
  }

  Widget dialogView() {
    return Material(
        type: MaterialType.transparency,
        child: Opacity(
          opacity: 1.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                decoration: BoxDecoration(
                    boxShadow: shadow,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                     'Select Image',
                      style:AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => _listener.openCamera(),
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Color(0xff007AFF),
                                )),
                            Expanded(
                              child: Container(
                                child: Text(
                                 'Camera',
                                  style:AppTheme.lightTheme.textTheme.titleMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _listener.openGallery(),
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.image,
                                  color: Color(0xff007AFF),
                                )),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Gallery',
                                  style:AppTheme.lightTheme.textTheme.titleMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  dismissDialog();
                },
                child: Container(
                  height: AppSizes.getHeight(context!,percent: 8),
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 0),
                  decoration: BoxDecoration(
                      boxShadow: shadow,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Text(
                               'Cancel',
                                style:  AppTheme.lightTheme.textTheme.titleMedium,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget roundedButton(
      String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
    var loginBtn = Container(
      margin: margin,
      padding: const EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration:  BoxDecoration(
        color: bgColor,
        borderRadius:  const BorderRadius.all(Radius.circular(100.0)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style:  TextStyle(
            color: textColor, fontSize: 18.0, fontWeight: FontWeight.normal),
      ),
    );
    return loginBtn;
  }
}
