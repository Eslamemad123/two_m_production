import 'package:image_picker/image_picker.dart';

Future<String?> UploadImage(bool isCamera) async {
  var imagePicker = await ImagePicker().pickImage(
    source: isCamera ? ImageSource.camera : ImageSource.gallery,
  );
  if (imagePicker != null) {
    return imagePicker.path;
  }
}
