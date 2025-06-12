import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UploadCubit_State.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadIntial());

  void uploadImage(File? image) async {
    if (image == null) {
      emit(UploadFailure(errormessage: "No image Selected"));
    }
    emit(UploadLoading());
    try {
      final storage = FirebaseStorage.instanceFor(
          bucket: "gs://campus-trade1.firebasestorage.app");
      final storageRef = FirebaseStorage.instance.ref().child(image!.path);
      UploadTask uploadTask = storageRef.putFile(image);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      emit(UploadSuccess(imageUrl: downloadUrl));
    } catch (ex) {
      emit(UploadFailure(errormessage: ex.toString()));
    }
  }
}
