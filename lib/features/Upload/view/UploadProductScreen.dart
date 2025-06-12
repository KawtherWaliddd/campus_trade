import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/text_styles.dart';

import '../Cubit/UploadCubit_class.dart';
import '../../SellScreen/presentation/view/Sellscreen.dart';
import '../Cubit/UploadCubit_State.dart';

import '../widget/AppBar_Upload.dart';
import '../widget/CustomSelectButton.dart';
import '../widget/SelectFile.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
        print("Image selected: ${image.path}");
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarUpload(isvisible: true),
      body: BlocConsumer<UploadCubit, UploadState>(
        listener: (context, state) {
          if (state is UploadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errormessage}')),
            );
          }
          if (state is UploadSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Image uploaded successfully')),
            );
          }
          if (state is UploadLoading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, bottom: 8, left: 20),
                child: Center(
                  child: Text(
                    "Upload a photo of your product",
                    style: TextStyles.black22Bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, right: 20, left: 20, bottom: 43),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Please upload a clear, well-lit photo of your product. Use a clean background.",
                    style: TextStyles.black14Regular400,
                  ),
                ),
              ),
              Selectfile(
                image: _image,
                UploadImage: () => pickImage(ImageSource.gallery),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 60),
                child: Row(
                  children: [
                    Container(
                        width: 170.w,
                        height: 1.h,
                        color: ColorManager.greyColor),
                    Text("OR", style: TextStyles.grey12Regular),
                    Container(
                        width: 170.w,
                        height: 1.h,
                        color: ColorManager.greyColor),
                  ],
                ),
              ),
              Customselectbutton(
                UploadImage: () => pickImage(ImageSource.camera),
                icon: Icons.photo_camera,
                text: "Open Camera",
                top: 40,
              ),
              if (state is UploadLoading)
                const Padding(
                  padding: EdgeInsets.all(20),
                ),
              Customselectbutton(
                text: "Continue",
                top: 130,
                UploadImage: () {
                  if (_image != null) {
                    context.read<UploadCubit>().uploadImage(_image);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SellScreen();
                    }));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please select an image first!")),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
