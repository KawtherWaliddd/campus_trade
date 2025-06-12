abstract class UploadState {}

class UploadIntial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {
  final String imageUrl;

  UploadSuccess({required this.imageUrl});
}

class UploadFailure extends UploadState {
  final String errormessage;

  UploadFailure({required this.errormessage});
}
