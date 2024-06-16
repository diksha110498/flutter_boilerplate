import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/core/app_theme/app_colors.dart';
import 'package:flutter_boilerplate/src/core/app_utils/app_sizes.dart';
import 'package:flutter_boilerplate/src/core/app_utils/app_utils.dart';
import 'package:flutter_boilerplate/src/core/di/app_repository.dart';
import 'package:flutter_boilerplate/src/core/models/upload_file_response.dart';

class FilePickerScreen extends StatefulWidget {

  int fileLimit;
  Function(List<String> selectedFiles,UploadFileResponse uploadFileResponse) uploadedFilesList;
  FilePickerScreen({required this.fileLimit,required this.uploadedFilesList});

  @override
  _FilePickerScreenState createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {

  List<String> selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _pickFiles,
          child: Container(
            width: AppSizes.getWidth(context,percent: 45),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.attachFilesBackgroundColor,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey),
            ),
            child: const Row(
              children: [
                Icon(Icons.add, color: Colors.black,size: 20,),
                SizedBox(width: 8.0),
                Text(
                  'Attach File(s)',
                  style: TextStyle(color: Colors.black,fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: selectedFiles.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10.0),
                  Expanded(child: Text(
                    selectedFiles[index].split('/').last,maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.0),
                  ),),
                  InkWell(
                    onTap: () {
                      // Show a confirmation dialog before removing the file
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete File?",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold)),
                            content: const Text("Are you sure you want to remove this file?",
                              style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.normal),),
                            actions: [
                              // Cancel button
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: const Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.normal)),
                              ),
                              // Confirm button
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                  // Remove the file
                                  if (mounted) {
                                    setState(() {
                                      selectedFiles.removeAt(index);
                                    });
                                  }
                                },
                                child: const Text("Yes",
                                    style: TextStyle(color: AppColors.primaryColor,fontSize: 14.0,fontWeight: FontWeight.normal)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.remove_circle_outline, color: Colors.red),
                  ),

                  const SizedBox(width: 10.0),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _pickFiles() async {
    if(selectedFiles.length < widget.fileLimit){
      FilePickerResult? files = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg'],
      );
      if (files != null && files.names.isNotEmpty) {
        //print('---files.paths---${files.paths.length}');
        File file = File(files.paths[0].toString());
        AppRepository.instance.uploadFileRequest(file).then((value){
          setState(() {
            selectedFiles.addAll(files.paths.map((file) {
              return file!;
            }));
            widget.uploadedFilesList(selectedFiles,value);
          });
        },onError: (error){

        });
      }
    }else{
      AppUtils.showSnackBar(context, 'You have reached to max limit to upload the files.');
    }
  }

}