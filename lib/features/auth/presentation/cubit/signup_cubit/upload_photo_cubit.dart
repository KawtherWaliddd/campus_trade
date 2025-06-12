import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoCubit extends Cubit<File?> {
  UploadPhotoCubit() : super(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    print("pickImage() called");

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        print("Image selected: ${pickedFile.path}");
        emit(File(pickedFile.path));
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }
}
