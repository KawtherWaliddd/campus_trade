import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/image_manager.dart';
import '../../../../core/utils/resources/text_styles.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({super.key});

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  File? selectedImage;
  bool isUploading = false;

  Future<File> getDefaultImageFile() async {
    final byteData = await rootBundle.load('assets/images/defaultAvatar.png');
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/defaultAvatar.png');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.PrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image preview
            CircleAvatar(
              radius: 75.r,
              backgroundColor: Colors.grey[300],
              backgroundImage: selectedImage != null
                  ? FileImage(selectedImage!)
                  : const AssetImage(ImageManager.uploadPhoto),
              child: isUploading ? const CircularProgressIndicator() : null,
            ),
            SizedBox(height: 20.h),

            if (!isUploading)
              CustomButton(
                labelText: 'Upload Profile Picture',
                backgroundColor: ColorManager.SecondaryColor,
                textStyle: TextStyles.White16Meduim,
                width: 230.w,
                height: 50.h,
                onPressed: pickImage,
              ),

            SizedBox(height: 50.h),

            if (!isUploading)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    labelText: 'Skip',
                    textStyle: TextStyles.blue14Bold,
                    borderColor: ColorManager.SecondaryColor,
                    backgroundColor: ColorManager.PrimaryColor,
                    width: 135.w,
                    height: 50.h,
                    onPressed: () async {
                      // Get the default image as File when skipped
                      final defaultFile = await getDefaultImageFile();
                      setState(() {
                        selectedImage = defaultFile;
                      });
                      Navigator.pop(context, selectedImage);
                    },
                  ),
                  SizedBox(width: 10.w),
                  CustomButton(
                    labelText: 'Start',
                    backgroundColor: ColorManager.SecondaryColor,
                    textStyle: TextStyles.white14Bold,
                    width: 208.w,
                    height: 50.h,
                    onPressed: () => Navigator.pop(context, selectedImage),
                    borderColor: ColorManager.PrimaryColor,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
